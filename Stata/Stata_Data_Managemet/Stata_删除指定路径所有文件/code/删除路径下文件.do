cd "C:\Users\mudaozi\Documents\WeChatPlatform\Stata_Data_Managemet\Stata_删除指定路径所有文件"

*******************
* 生成演示数据
*******************
cap mkdir "temp_file"
cap mkdir "temp_file\dta"
cd "temp_file"

forvalues i = 1/10{
	!echo test -> "dta\test`i'.dta"
	!echo test -> test`i'.txt
}

ftree,s(..\tempFileTree) d(tree)

*************************
* 方式一：使用扩展宏
*************************
cd ".\temp_file"
fs 
foreach f in `r(files)'{
	erase `f'
}

local files : dir . files "*.txt"
foreach f of local files {
    erase "`f'"
}

***************************
* 方式二：调用 shell 命令
***************************
!rmdir /s /q "..\temp_file"