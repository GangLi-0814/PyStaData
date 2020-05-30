
cd "C:\Users\mudaozi\Documents\WeChatPlatform\Stata_Data_Managemet\爬取CFPS小课堂并制作PDF"



**********************
* 爬取文献列表和链接
**********************

* 查询截止页码
copy "http://www.isss.pku.edu.cn/cfps/xzyj/wxzsm/index.htm" cfpsClass.txt, replace
infix strL v 1-20000 using cfpsClass.txt, clear
keep if index(v, "共有:")
if ustrregexm(v,`"共有:<font color="#ff0000">(\d+)</font>页"'){
local a = ustrregexs(1)
dis "共有：`a' 页！"
}

* 爬取文献标题和链接
forvalues p =1/`a'{
	if `p' == 1{
		local p = `""'
	}
	else{
		local p = `p' - 1
	}
	
	copy "http://www.isss.pku.edu.cn/cfps/xzyj/wxzsm/index`p'.htm" cfpsClass.txt, replace
	
	infix strL v 1-20000 using cfpsClass.txt, clear
	keep if index(v,`"<a href="') & index(v,`"title"') & index(v, `"arget="_blank">"') 
	gen title = ustrregexs(1) if ustrregexm(v,`"title="(.*?)""') == 1
	gen link = "http://www.isss.pku.edu.cn/cfps/xzyj/wxzsm/" + ustrregexs(1) ///
	if ustrregexm(v,`"<a href="(.*?)""') == 1
	keep title link
	
	save "./temp/temp`p'.dta", replace
}

* 保存数据
openall, directory("./temp/")
sort link
compress
save "./result/allPaperList.dta",replace


*******************************************
* 调用 Python 爬取网页内容并存为 Markdown
*******************************************
cd result
use "allPaperList.dta", clear

* 清洗文献标题 -> 合规文件名
gen title2 = usubinstr( ///
		usubinstr(ustrregexra(title,"[[:punct:]]","")," ","_",.) ///
		,"$","_",.)	
replace title2 = usubinstr(usubinstr(title2,"_|_","_",.),"_","",-1)
save "allPaperList.dta", replace

	
******************************Python*******************	
python:
import requests
import html2text as ht

title = Data.get(var='title')
title2 = Data.get(var='title2')
links = Data.get(var='link')

for i in range(len(links)):
    html = requests.get(links[i])
    html.encoding = 'utf8'
    md = ht.html2text(html.text)
    md = md.split("##")
    filepath = title2[i] + ".md"

    with open(filepath, "w", encoding='utf8') as f:
        for row in range(3, len(md)):
            f.write(md[row])	
end
*******************************************************
