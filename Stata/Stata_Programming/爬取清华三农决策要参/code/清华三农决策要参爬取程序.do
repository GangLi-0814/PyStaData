*清华大学中国农村研究院《三农决策要参》
*Stata 15


cd "D:\PyStaData\Stata\Stata_Programming\爬取清华三农决策要参" //修改路径



***第一步，提取每一页

copy "http://www.cirs.tsinghua.edu.cn/sannjcyc/index.jhtml" "page1.txt",replace


forv i=2(1)13{
copy "http://www.cirs.tsinghua.edu.cn/sannjcyc/index_`i'.jhtml" "page`i'.txt",replace
}

***第二步，提取每页中的三农决策要参链接

**尝试第一页
infix strL v 1-20000 using page1.txt,clear
format v %200s
keep if index(v,`"[三农决策要参]"')
count

drop if _n == 1  //第一页中的第一行是简介，需要去掉；其他页的不用


split v,p(`"href=""')

split v3,p(`"" title=""')
gen 链接="http://www.cirs.tsinghua.edu.cn/"+v31



split v32,p(`"" target=""')
gen 名录=v321

split v321,p(`"第"')

split v3212,p(`"期"')
gen 期数=v32121

keep 名录 期数 链接

save page1,replace


***找到规律后对付剩下的

 foreach i of numlist  2/13 {

infix strL v 1-20000 using page`i'.txt,clear
format v %200s
keep if index(v,`"[三农决策要参]"')
count



split v,p(`"href=""')

split v3,p(`"" title=""')
gen 链接="http://www.cirs.tsinghua.edu.cn/"+v31



split v32,p(`"" target=""')
gen 名录=v321

split v321,p(`"第"')

split v3212,p(`"期"')
gen 期数=v32121

keep 名录 期数 链接

save page`i',replace


}



***第三步，合并所有页
use page1,clear

 foreach i of numlist  2/13{
append using page`i'
}

order 期数 名录  链接
destring 期数,replace
sort 期数


count
save 三农决策要参名录,replace  //得到所有各期目录及链接




***第四步，抓取每一期页面数据

use 三农决策要参名录 ,clear


gen check=_n

count


local N=_N

 forvalue i=1(1)`N' {
  local url`i'=链接[`i'] 
 }

 forvalue j=1(1)`N' {
 copy "`url`j''" "temp`j'.txt"  ,replace
  }



***第五步，提取每一期页面中的PDF链接


foreach i of numlist  1(1) 170{
infix strL v 1-20000 using temp`i'.txt,clear
format v %200s
keep if index(v,`".pdf"') 


split v,p(`"<a href=""')

split v2,p(`"" id"')

gen PDF链接="http://www.cirs.tsinghua.edu.cn"+v21


save temp`i',replace
}

// 第171期没有PDF

foreach i of numlist  172(1) 250{
infix strL v 1-20000 using temp`i'.txt,clear
format v %200s
keep if index(v,`".pdf"') 


split v,p(`"<a href=""')

split v2,p(`"" id"')

gen PDF链接="http://www.cirs.tsinghua.edu.cn"+v21



save temp`i',replace
}

*****合并所有PDF链接

use temp1,clear

 foreach i of numlist  2(1)170 172(1)250 {
append using temp`i'
}

count

*****生成PDF链接对应期数
split v22,p(`"）.pdf"')
split v221,p(`"2013（"')

gen 期数1=v2212

split v2211,p(`"总第"')

split v22112,p(`"期"')

gen 期数=v221121
replace 期数=期数1 if missing(期数)
destring 期数,replace

keep 期数 PDF链接
sort 期数

****与原来名录 合并

merge 1:1 期数 using 三农决策要参名录

list 期数 if _merge!=3

drop _merge

****去年目录中的非法字符

replace 名录=subinstr(名录," ?","",.)
replace 名录=subinstr(名录,"&lt;br&gt;","",.)
replace 名录=subinstr(名录," ","",.)
replace 名录=" 第218期：乡村资源变现发展资本，家庭经济助力乡村振兴" if 期数==218

order 期数 名录 链接 PDF链接
sort 期数

******生成最终数据

save 三农决策要参名录+PDF链接,replace





****最后：下载所有PDF

use 三农决策要参名录+PDF链接,clear



local N=_N

 forvalue i=1(1)`N' {
  local url`i'=PDF链接[`i'] 
    local name`i'=名录[`i'] //用名录完整名称命名PDF文件
 }

 forvalue j=1(1)`N' {
 copy `url`j''  `name`j''.pdf  ,replace
  }

 

  
  
  ******导出各期名录到word
  
  	putdocx clear
		putdocx begin,pagesize(A4) font(宋体, "12")
		putdocx paragraph, halign(center)	
		putdocx text (""), bold		
      putdocx table tbl = data("名录") , varnames layout(autofitcontents) halign(center) 
      putdocx table tbl(1,1) = ("三农决策要参1-250名录")

		
   putdocx save 三农决策要参1-250名录.docx, replace

    shellout 三农决策要参1-250名录.docx 
  
  ****END
  
  



*获取文件夹下文件名
cd "D:\PyStaData\Stata\Stata_Programming\爬取清华三农决策要参"
cap log close
log using category.txt,replace
cd "D:\PyStaData\Stata\Stata_Programming\爬取清华三农决策要参1-250"
fs
log close

cd "D:\PyStaData\Stata\Stata_Programming\爬取清华三农决策要参"
infix strL v 1-20000 using category.txt,clear
format v %200s
keep if index(v,`"期"')
replace v=subinstr(v,".pdf","  ",.)
replace v=subinstr(v,"{res}","",.)
gen num = real(regexs(1)) if regexm( v ,"([0-9]+)")
order num v
sort num
list v,sep(0) noo
compress

outfile v using "list.txt",noquote replace 