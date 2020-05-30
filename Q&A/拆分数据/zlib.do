				************************************************                                                                              
				/*想看什么书？让stata帮你找！
						————爬取中南财经政法大学图书馆藏书信息*/
				***********************************************
							*目录				
								*一、爬取数据
								*二、数据整理
									*（一）剔除
									*（二）拆分
									*（三）合并

*------------------------------------begin--------------------------------------------------

*---------------------------
*****一、爬取数据
*---------------------------
//设置路径
cap mkdir "C:\stata15\ado\personal\findbooks"
cd  "C:\stata15\ado\personal\findbooks"

//设置关键词
local keyword = "stata"    //记得设置终止页！

forvalues p = 1/500{    //多于实际页面也会抓取，不会报错。
	cap copy "http://202.114.238.66:81/NTRdrBookRetr.aspx?page=`p'&strKeyValue=`keyword'&strType=text" bookinfo.txt,replace
	     
	     //处理到空页该怎么停下来？
	     //思路：1.字符长度；2.找不到某些信息；3.先找到有多少页，之后当成循环中的参数；4.根据页面信息手工设置。
	     if `p' > 4 {   // 4 为根据网页总 page手工设置
	          dis "共- `=`p'-1'- 页，抓取完毕!"
	          continue ,break
	     }

	 //index不支持正则，而且index会先执行，所以subinfile要分两步走。
	qui subinfile bookinfo.txt,from(`"<a href=(.*)target=‘_blank’>"') ///
	to(`"<span class="name">书名：<strong>"')  fromregex  replace
	
	qui subinfile bookinfo.txt, index(`"<span class"')  ///
	from(`"</strong></span>"' `"/</a>:(.*)|</a>:(.*)"' `"<span class="(.*)">"')  ///
	to("" "" "") fromregex  drop("<strong id=") replace
	
	cap infix strL v 1-20000 using bookinfo.txt,clear
	cap split v,p(`"：<strong>"')
	cap drop v
	cap save book`p'.dta,replace
	dis "第 -`p'- 页"
}
openall

qui compress
save "bookinfo.dta",replace
export excel findbooks.xlsx,replace firstrow(varlabel) 

//善后
forvalues p = 1/80{
	cap erase "book`p'.dta"
}

*---------------------------
*****二、数据整理
*---------------------------
*（一）剔除 丛书 和 价格
*---------------------------
use bookinfo.dta,clear
qui drop if v1 == "丛书" | v1 == "价格"
qui save bookinfo_process.dta,replace

*--------------
*（二）拆分
*--------------
cap mkdir dataprocess     
copy bookinfo_process.dta dataprocess\bookinfo_process.dta  //复制到新文件夹
cd C:\stata15\ado\personal\findbooks\dataprocess

use bookinfo_process.dta,clear
levelsof v1,local(v)
foreach n in `v'{
preserve
	qui keep if v1 == "`n'"
	qui rename v2 `n'
	qui gen id = _n
	qui drop v1 
	qui save `n'.dta,replace  //存到新文件夹
	dis "`n'.dta 已保存"
restore
}

*--------------------
*（三）合并
*--------------------
//以防报错，先删除和结果的.dta文件
qui cap erase bookinfo_process.dta
qui cap erase bookinfo_result.dta

qui fs *.dta
qui use 书名.dta,clear
foreach f in `r(files)'{
	qui merge 1:1 id using `f',nogenerate update
	}
qui cap drop id 
qui order 书名 作者 分类号 索书号 页数 出版社 出版时间 ISBN 
qui compress
qui save bookinfo_result.dta,replace 
export excel using bookinfo_result.xlsx,replace firstrow(varlabels)
*shellout bookinfo_result.xlsx
*---------------------------------------end----------------------------------------------
