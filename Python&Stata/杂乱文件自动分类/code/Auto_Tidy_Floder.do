
cd "..\files"

* Create Floders
fs
foreach file in `r(files)'{
	local floder =  ustrregexrf("`file'","^.*\.","",.) 
	dis as result "`floder' 文件夹已创建..."
	cap mkdir "`floder'"
	}
	
* Move Files
fs
foreach file in `r(files)'{
	local type =  ustrregexrf("`file'","^.*\.","",.)
	if ustrregexrf("`file'","^.*\.","",.) == "`type'"{
		!move "`file'" "`type'"
		}
	}