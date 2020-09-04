*! version 2.0 3/17/2020: Danial Hoepfner danial.hoepfner@gmail.com
cap program drop qualtrics
program define qualtrics, rclass
version 13
syntax anything, [ /// Set options and those that are used in more than one function
				Token(string) /// API Token from Qualtrics, can specify both with each run or set them
				Center(string) /// Data Center from Qualtrics can specify both with each run or set them
				Password(string) /// Password to set qualtrics or decode  
				User(string) /// User name option to associate with password if 
				/// Get options	
				ID(string) /// Survey ID
				CSV(string) /// Where to save the csv
				DTA(string) /// Where to save the DTA
				VAluelabs /// Save value labels instead of numeric
				CLean ///Extract and apply labels and value labels etc.
				RELAB ///list out label variable commands to make manual adjustments
				REVALlab ///list out value label define commands to make adjustments 
				PREserve /// Preseve and reload existing dataset (Only relevant for get function)
				/// List options
				Match(string) /// Survey name to match expression (regular expression)
				Active(string) /// Survey is active(true) or inactive(false)
				MODRange(string asis) /// Date range survey was last modified 
				CREATERange(string asis) /// Date range survey was created
				/// Undocumented
				Method(string) ///Whether to use wget64 or curl, default is curl
				] 
************************Capturing things I might Change*************************
************************Capturing things I might Change*************************
************************Capturing things I might Change*************************
local original_lines `"`c(linesize)'"'
local restoredata = 0
if `c(k)' != 0 & `=_N' != 0 {
	tempfile orginal_data
	qui sa `orginal_data'
	local restoredata = 1 
}	
**********************End Capturing things I might Change***********************
**********************End Capturing things I might Change***********************
**********************End Capturing things I might Change***********************


capture which sxpose.ado
if _rc==111 ssc install sxpose.ado

timer clear 13
timer on 13
if `"`method'"'!=`"curl"' local method `"curl"' //Setting curl as default
se linesize 255
if !inlist(`"`anything'"',`"list"',`"get"',`"set"') {
	if `restoredata' == 1 qui use	`orginal_data', clear
	set linesize `original_lines'
	di as error `"Please enter -list-, -get- or -set-"'
	error 198
}
if `"`clean'"'!=""&`"`valuelabs'"'!="" {
	if `restoredata' == 1 qui use	`orginal_data', clear
	di as error `"CLean and VAluelabs options not compatible"'
	set linesize `original_lines'
	error 184
}	


****************************************************Set Data Center and Token*****************************************************
****************************************************Set Data Center and Token*****************************************************
****************************************************Set Data Center and Token*****************************************************
if `"`anything'"' == `"set"' { //If using set function
	if inlist(`""',`"`password'"',"`token'","`center'") {
	    if `restoredata' == 1 qui use	`orginal_data', clear
		set linesize `original_lines'
		di as error `"You must specify Password, Token, and Center"'
		error 198
	}
	local salt =floor(runiform()*50)
	while length(`"`password'"')<length(`"`token'"') {
		local password `"`password'`password'"'
	}

	*!DH Note 3/18/2020: Encoding Password
	local plen=length(`"`password'"')
	local encpassword 
	forvalues p=1/`plen' {
		local curlet=substr(`"`password'"',`p',1)
		local char 
		forvalues i=1/255 {
			if `i'!=96 {
				if `"`=char(`i')'"'==`"`curlet'"' {
					local encpassword `"`encpassword'`:di %03.0f `i''"'
					continue, break
				}
			}	
		}
	}
	*!DH Note 3/18/2020: Now adding password character value to token item with a random number
	local tlen=length(`"`token'"')
	local enctoken
	forvalues p=1/`tlen' {
		local curlet=substr(`"`token'"',`p',1)
		if `p' == 1	local pnum=substr(`"`encpassword'"',`p',3)
		if `p' > 1	local pnum=substr(`"`encpassword'"',`p'*3-2,3)
		local char 
		forvalues i=1/255 {
			if `i'!=96 {
				if `"`=char(`i')'"'==`"`curlet'"' {
					local encval= `i'+`pnum'-`salt'
					local enctoken `"`enctoken'`:di %03.0f `encval''"'
					continue, break
				}
			}	
		}
	}
	*!DH Note 3/18/2020: Saving in personal .ado path
	local enctokenstr `"`enctoken'`:di %03.0f `salt''"'
	if `"`user'"' != "" {
    	local ulen=length(`"`user'"')
		local warn `"Warning! it is best to only use a-z, A-Z, 0-9, _ and space for your User name"'
		local ok =0
		forvalues p=1/`ulen' {
			local curlet=substr(`"`user'"',`p',1)
			foreach l in `c(alpha)' `c(ALPHA)' 0 1 2 3 4 5 6 7 9 9 {
			    if inlist(`"`curlet'"',`"`l'"',`" "',`"_"') local ++ok
			}
		}
		if `ok' == `ulen' local warn

		
	}
	
	local filecont 
	cap file close outgo
	cap macro drop outgo
	file open outgo using `"`c(sysdir_personal)'`user'qualtricscreds.txt"', replace write
	local filecont  `"`center' `enctokenstr'"' 
	file write outgo `"`filecont'"'
	file close outgo
	macro drop outgo
	di as smcl `"{text}{hline 160}"'
	if `"`warn'"' != `""' di as error `"`warn'"'
	di as result `"Data center information and encrypted token saved to `c(sysdir_personal)'`user'qualtricscreds.txt"'
	di as result `"You can now run qualtrics using your password only rather than specifying the token and data center"'
	di as smcl `"{text}{hline 160}"'
	if `restoredata' == 1 qui use	`orginal_data', clear
	set linesize `original_lines'
	exit
}


**************************************************End Set Data Center and Token***************************************************
**************************************************End Set Data Center and Token***************************************************
**************************************************End Set Data Center and Token***************************************************


**********************************************Retrieving Token and Data Center**********************************************
**********************************************Retrieving Token and Data Center**********************************************
**********************************************Retrieving Token and Data Center**********************************************

if `"`anything'"' != `"set"' {
	local getqtoken = 1
	if `"`token'"' != `""' & `"`center'"' !=`""' local getqtoken = 0 
	if `"`token'"' == `""' & `"`center'"' ==`""' & `"`password'"' == `""' {
		if `restoredata' == 1 qui use	`orginal_data', clear
		set linesize `original_lines'
		di as error `"You Must either specify the Token and Center options or use -qualtrics set- and set a password to encode the qualtrics data center and token"'
		error 198
	}
	if `getqtoken' == 1 {
		cap confirm file `"`c(sysdir_personal)'`user'qualtricscreds.txt"'
		if _rc != 0 {
			if `restoredata' == 1 qui use	`orginal_data', clear
			set linesize `original_lines'
			di as error `"Text file containing data center and encrypted token not found. Check for `c(sysdir_personal)'`user'qualtricscreds.txt or Use -qualtrics set- and set a password to encode the qualtrics data center and token"'
			error 198
		}
		*!DH Note 3/18/2020: Import file with token
		clear
		mata: input = cat(`"`c(sysdir_personal)'`user'qualtricscreds.txt"')	 
		qui getmata input //Make as variable
		tokenize `"`=input[1]'"'
		local center `"`1'"'
		local enctokenstr `"`2'"'
		*!DH Note 3/18/2020: Encoding Password
		local plen=length(`"`password'"')
		local decpassword 
		forvalues p=1/`plen' {
			local curlet=substr(`"`password'"',`p',1)
			local char 
			forvalues i=1/255 {
				if `i'!=96 {
					if `"`=char(`i')'"'==`"`curlet'"' {
						local decpassword `"`decpassword'`:di %03.0f `i''"'
						continue, break
					}
				}	
			}
		}
		local enctoken =substr(`"`enctokenstr'"',1,length(`"`enctokenstr'"')-3)
		local salt =substr(`"`enctokenstr'"',-3,3)

		while length(`"`decpassword'"')<length(`"`enctoken'"') {
			local decpassword `"`decpassword'`decpassword'"'
		} 

		local tlen=length(`"`enctoken'"')
		local dectoken
		forvalues p = 1(3)`tlen' {
			local pnum=substr(`"`decpassword'"',`p',3)
			local tnum=substr(`"`enctoken'"',`p',3)
			local num = `tnum'-`pnum'+`salt'
			local dectoken `"`dectoken'`=char(`num')'"'
		}
		local token `"`dectoken'"'
	}
}	
********************************************End Retrieving Token and Data Center********************************************
********************************************End Retrieving Token and Data Center********************************************
********************************************End Retrieving Token and Data Center********************************************


local apiheader `"X-API-TOKEN: `token'"' //Setting header information for api token
local headercont `"Content-Type: application/json"' //Setting another header condition needed


***********************************************************List Surveys Function************************************************************
***********************************************************List Surveys Function************************************************************
***********************************************************List Surveys Function************************************************************

if `"`anything'"' == `"list"' { //If using survey list function
	local inpath `"list.txt"' //Setting path to import API response
	cap rm `"`inpath'"'
	local url `"https://`center'.qualtrics.com/API/v3/surveys"' //Url for this API call
	if `"`method'"' == `"curl"' { // If curl
		*Call to receive json file with surveys
		!curl -H "`apiheader'" "`url'" -o "`inpath'"  
	}
	if `"`method'"' == `"wget64"' { //if wget64
		*Call to receive json file with surveys
		!wget64  --header="`apiheader'" "`url'" -O "`inpath'" 
	}
	clear
	cap confirm file `"`inpath'"'
	if _rc !=0 {
		di as error `"Unable to find downloaded survey list file to process. Check your token and data center or your password"'
		di as error `"On occasion, the Qualtrics API does not respond reliably, if you have already checked your password or token and data center, try again in little while"'
		error 6
	}
	mata: input = cat(`"`inpath'"')	 //Import file that was downloaded
	qui getmata input //Make as variable
	if regexm(`"`=input[1]'"',`"400 Bad Request: invalid header value"') {
		if `restoredata' == 1 qui use	`orginal_data', clear
		di as error `"Qualtrics returns "400 Bad Request: invalid header value". Check your token and data center or your password"'
		error 198
	}
	
	************************Getting Multiple Pages if needed************************
	************************Getting Multiple Pages if needed************************
	************************Getting Multiple Pages if needed************************
	local newurl
	qui count if regexm(input,`""nextPage":"(https://.+offset=[0-9]+)""')
	local renextpage `r(N)'
	while `renextpage' == _N { //Change to while once I have it right
		local newurl = regexs(1)
		*di `"`newurl'"'
		preserve 
		local inpath `"list.txt"' //Setting path to import API response
		cap rm `"`inpath'"'
		local url `"`newurl'"' //Url for this API call
		if `"`method'"' == `"curl"' { // If curl
			*Call to receive json file with surveys
			!curl -H "`apiheader'" "`url'" -o "`inpath'"  
		}
		if `"`method'"' == `"wget64"' { //if wget64
			*Call to receive json file with surveys
			!wget64  --header="`apiheader'" "`url'" -O "`inpath'" 
		}
		clear
		mata: input = cat(`"`inpath'"')	 //Import file that was downloaded
		qui getmata input //Make as variable
		tempfile newpage
		qui sa `newpage'
		restore
		append using `newpage'
		qui count if regexm(input,`""nextPage":"(https://.+offset=[0-9]+)""')
		local renextpage `r(N)'
	}
	qui count
	if `r(N)'>1 {
		forvalues  i = 1 / `r(N)' {
			qui replace input = input + input[_n-1] if _n > 1
		}
		qui keep if _n == _N	
	}
	**********************End Getting Multiple Pages if needed**********************
	**********************End Getting Multiple Pages if needed**********************
	**********************End Getting Multiple Pages if needed**********************

	
	
	*****************Parsing out desired information from JSON file*****************
	*****************Parsing out desired information from JSON file*****************
	*****************Parsing out desired information from JSON file*****************

	qui replace input=subinstr(input,`"id":"',`"~id":"',.)
	qui split input, p("~")
	qui drop input
	qui gen n=1
	qui reshape long input, i(n) j(line)
	qui drop in 1
	local getlist `"id name ownerId lastModified creationDate isActive"'
	local gct=1
	foreach gt of local getlist {
		local ++gct
		local stop `"`:word `gct' of `getlist''"'
		cap drop `gt'
		qui gen `gt'=regexs(1) if regexm(input,`"`gt'":"(.+)".+`stop'"')
	}	
	qui replace isActive=regexs(1) if regexm(input,`""isActive":(.+)}"')
	qui replace isActive=regexr(isActive,"}.+","")
	bysort id: gen keep =_n==_N
	qui keep if keep == 1
	qui drop keep 
	***************End Parsing out desired information from JSON file***************
	***************End Parsing out desired information from JSON file***************
	***************End Parsing out desired information from JSON file***************
	
	******************************List Subset Options*******************************
	******************************List Subset Options*******************************
	******************************List Subset Options*******************************
	qui count
	local total_surveys `r(N)'
	if `total_surveys' == 0 {
	    if `restoredata' == 1 qui use	`orginal_data', clear
		if `restoredata' == 0 qui clear
		set linesize `original_lines'
		di as error `"No surveys found associated with your token and data center. Check your token and data center or your password"'
		di as error `"On occasion, the Qualtrics API does not respond reliably, if you have already checked your password or token and data center, try again in little while"'
		error 6   		
	}
	
	************************************RE Match************************************
	************************************RE Match************************************
	************************************RE Match************************************
	if `"`match'"' !=`""' {
	    qui keep if regexm(name,`"`match'"')
	}
	**********************************End RE Match**********************************
	**********************************End RE Match**********************************
	**********************************End RE Match**********************************

	*******************************(In)Active surveys*******************************
	*******************************(In)Active surveys*******************************
	*******************************(In)Active surveys*******************************
	if `"`active'"' !=`""' {
		if !inlist(trim(itrim(lower(`"`active'"'))),`"true"',`"false"') {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in Active option: Must specify either true or false"'
			set linesize `original_lines'
			error 198
		}
		qui keep if isActive == trim(itrim(lower(`"`active'"')))
	}
	*****************************End (In)Active surveys*****************************
	*****************************End (In)Active surveys*****************************
	*****************************End (In)Active surveys*****************************

	******************************Modified Date Range*******************************
	******************************Modified Date Range*******************************
	******************************Modified Date Range*******************************

	if `"`modrange'"' !=`""' {
		if !regexm(`"`modrange'"',":") {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in MODRange option: Start Date and End Date must be separated by a colon(:)"'
			set linesize `original_lines'
			error 198
		}
		qui split lastModified, p(`"T"')
		cap drop date
		qui gen date= date(lastModified1,"YMD")
		foreach loca in startdate enddate {
		    local `loca'
		}
		tokenize `"`modrange'"', p(`":"')
		local startdate=date(`"`1'"',"MDY")
		local enddate=date(`"`3'"',"MDY")
		if `"`startdate'"' == `"."' {
			if `restoredata' == 1 qui use	`orginal_data', clear
   			di as error `"Error in MODRange option: Start Date not Valid, Enter a string in Month Day Year format"'
			set linesize `original_lines'
			error 198
		}
		if `"`enddate'"' == `"."' {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in MODRange option: End Date not Valid, Enter a string in Month Day Year format"'
			set linesize `original_lines'
			error 198
		}
		if `startdate' > `enddate' {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in MODRange option: Start Date is after End Date"'
			set linesize `original_lines'
			error 198
		}
		qui keep if inrange(date,`startdate',`enddate')	
	}

	****************************End Modified Date Range*****************************
	****************************End Modified Date Range*****************************
	****************************End Modified Date Range*****************************

	*******************************Created Date Range*******************************
	*******************************Created Date Range*******************************
	*******************************Created Date Range*******************************

	if `"`createrange'"' !=`""' {
		if !regexm(`"`createrange'"',":") {
			if `restoredata' == 1 qui use	`orginal_data', clear
   			di as error `"Error in CREATERange option: Start Date and End Date must be separated by a colon(:)"'
			set linesize `original_lines'
			error 198
		}
		qui split creationDate, p(`"T"')
		cap drop date
		qui gen date= date(creationDate1,"YMD")
		foreach loca in startdate enddate {
		    local `loca'
		}
		tokenize `"`createrange'"', p(`":"')
		local startdate=date(`"`1'"',"MDY")
		local enddate=date(`"`3'"',"MDY")
		if `"`startdate'"' == `"."' {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in CREATERange option: Start Date not Valid, Enter a string in Month Day Year format"'
			set linesize `original_lines'
			error 198
		}
		if `"`enddate'"' == `"."' {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in CREATERange option: End Date not Valid, Enter a string in Month Day Year format"'
			set linesize `original_lines'
			error 198
		}
		if `startdate' > `enddate' {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Error in CREATERange option: Start Date is after End Date"'
			set linesize `original_lines'
			error 198
		}
		qui keep if inrange(date,`startdate',`enddate')	
	}

	*****************************End Created Date Range*****************************
	*****************************End Created Date Range*****************************
	*****************************End Created Date Range*****************************
	

	****************************End List Subset Options*****************************
	****************************End List Subset Options*****************************
	****************************End List Subset Options*****************************

	
	
	**************************Making SMCL table of information and setting returned values*****************
	qui count
	local filtered_files `r(N)'
	di as smcl `"{text}{hline 160}"'
	di as result `"Found `total_surveys' surveys total"'
	if `filtered_files' != `total_surveys' di as result `"`filtered_files' met the criteria specified"'
	di as smcl `"{text}{hline 160}"'
	local c1 80
	local c2 100
	local c3 124
	local c4 146
	di as smcl `"{result}name {col `c1'} surveyid {col `c2'} lastModified {col `c3'} creationDate {col `c4'} isActive"'
	di as smcl `"{text}{hline 160}"'
	gsort - lastModified
	qui count 
	forvalues i=1/`r(N)' {
		di as smcl `"{result}`=name[`i']' {col `c1'} `=id[`i']' {col `c2'} `=lastModified[`i']'  {col `c3'} `=creationDate[`i']'  {col `c4'} `=isActive[`i']'"'
		return local key`i' `"`=id[`i']'"'
		foreach rt of local getlist{
			return local `rt'`i' `"`=`rt'[`i']'"'
		}	
		return local filtered_surveys `"`filtered_files'"'
		return local total_surveys `"`total_surveys'"' 
	}
	di as smcl `"{text}{hline 160}"'
	**********************END Making SMCL table of information and setting returned values****************
	if `restoredata' == 1 qui use	`orginal_data', clear
	set linesize `original_lines'
	cap rm `"`inpath'"'
	exit
	*******************************************************End List Surveys Function********************************************************
	*******************************************************End List Surveys Function********************************************************
	*******************************************************End List Surveys Function********************************************************

	
}				
*********************************************Get Surveys Function******************************************************
*********************************************Get Surveys Function******************************************************
*********************************************Get Surveys Function******************************************************
if `"`anything'"'==`"get"' { // if get function selected
	*******************************Download Survey to csv**************************************************************
	local surveyid `"`id'"' //Survey ID you want from here
	local filetyp `"csv"' //file format to request
	
	if `"`surveyid'"' == "" {
			if `restoredata' == 1 qui use	`orginal_data', clear
   			di as error `"Must Specify survey ID using ID option"'
			set linesize `original_lines'
			error 198
		}
	
	if `"`csv'"'==`""' {
		di as error `"must specify a location to save the csv, csv file name is provided by qualtrics"' //Need location for CSV, mostly because I think we should have one on hand
		if `restoredata' == 1 | `"`preserve'"' != "" qui use `orginal_data', clear
		set linesize `original_lines'
		error 198
	}
	***Windows or Mac File Path
	if `"`c(os)'"' == `"Windows"' {
		local path=subinstr(`"`csv'"',"/","\",.) //Where data will be downloaded to
		if substr(`"`path'"',-1,1) != `"\"' local path `"`path'\"'
		local upath=subinstr(`"`csv'"',"\","/",.) //Where data will be downloaded to
		if substr(`"`upath'"',-1,1) != `"/"' local upath `"`upath'/"'
	}
	if `"`c(os)'"' != `"Windows"' {
		local path=`"`csv'"' //Where data will be downloaded to
		if substr(`"`path'"',-1,1) != `"/"' local path `"`path'/"'
		local upath=`"`csv'"' //Where data will be downloaded to
		if substr(`"`upath'"',-1,1) != `"/"' local upath `"`upath'/"'
	}
	if `"`c(os)'"' == `"Windows"' {
		if 	`"`valuelabs'"'==`""' local post `"{\"surveyId\": \"`surveyid'\", \"format\": \"`filetyp'\"}"' //JSON request for data
		if 	`"`valuelabs'"'!=`""' local post `"{\"surveyId\": \"`surveyid'\", \"format\": \"`filetyp'\", \"useLabels\":true}"' //JSON request for data
	}
	if `"`c(os)'"' != `"Windows"' {
		if 	`"`valuelabs'"'==`""' local post `"{"surveyId": "`surveyid'", "format": "`filetyp'"}"' //JSON request for data
		if 	`"`valuelabs'"'!=`""' local post `"{"surveyId": "`surveyid'", "format": "`filetyp'", "useLabels":true}"' //JSON request for data
	}
	local inpath "`path'reqfile.txt" //This location for response to our request for a file
	local url "https://`center'.qualtrics.com/API/v3/responseexports/" //url call for this process
	if `"`method'"'==`"wget64"' {
		cap rm `"`inpath'"'
		*API request for file to be generated
		!wget64 --post-data="`post'" --header="`apiheader'" --header="`headercont'"  "`url'" -O "`inpath'" 
		clear
		mata: input = cat(`"`inpath'"')	//Importing file that contains information to check the progress of our request
		getmata input
		if regexm(`"`=input[1]'"',`"400 Bad Request: invalid header value"') {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Qualtrics returns "400 Bad Request: invalid header value". Check your token and data center or your password"'
			error 198
		}
		gen request=regexs(1) if regexm(input, `""id":"(.+)"},"m"') //Extracting request ID to check progress
		local request `"`=request[1]'"'
		local retry=1
		local tryct=0
		while `retry'==1 &`tryct'<100 { //Repeat checking for the file to be ready until it is
			sleep 1000 //wait a bit for file to be created
			local ++tryct
			local inpath "`path'progress.txt"
			local url "https://`center'.qualtrics.com/API/v3/responseexports/"
			*Call for file which tells us if the data is ready to download
			!wget64 --header="`apiheader'" "`url'`request'" -O "`inpath'" 
			clear
			mata: input = cat(`"`inpath'"')	
			getmata input
			gen status=regexs(1) if regexm(input, `""status":"(.+)"},"m"') //extracting the status. i.e. complete or not
			cap drop file
			if `"`=status[1]'"'==`"complete"' { //if file is ready
				local retry=0 //stop while loop
				gen file=regexs(1) if regexm(input, `""file":"(.+)","s"') //get file url to download
			}
			if `tryct' == 100 {
				if `restoredata' == 1 qui use	`orginal_data', clear
				set linesize `original_lines'
				di as error `"Qualtrics API not producing file. Check your token and data center or your password"'
				di as error `"On occasion, the Qualtrics API does not respond reliably, if you have already checked your password or token and data center, try again in little while"'
				error 6   	
			}	
		} //End while retry==1	
		local file `"`=file[1]'"'
		local inpath "`path'responses.zip"
		cap rm `"`inpath'"'
		*****Now download file
		!wget64 --header="`headercont'" --header="`apiheader'" "`file'" -O "`inpath'" 
	} //end if wget64
	if `"`method'"'==`"curl"' { //Except for the curl/wget commands, this is exactly the same as wget version
		cap rm `"`inpath'"'
		if `"`c(os)'"' == `"Windows"' {
			!curl -X POST -H "`apiheader'" -H "`headercont'" -d "`post'" "`url'" -o "`inpath'"
		}	
	if `"`c(os)'"' != `"Windows"' {
			!curl -X POST -H "`apiheader'" -H "`headercont'" -d '`post'' "`url'" -o "`inpath'"
		}
		clear
		local inpath "`path'reqfile.txt"
		mata: input = cat(`"`inpath'"')	
		getmata input
		if regexm(`"`=input[1]'"',`"400 Bad Request: invalid header value"') {
			if `restoredata' == 1 qui use	`orginal_data', clear
			di as error `"Qualtrics returns "400 Bad Request: invalid header value". Check your token and data center or your password"'
			error 198
		}
		gen request=regexs(1) if regexm(input, `""id":"(.+)"},"m"')
		local request `"`=request[1]'"'
		local retry=1
		local tryct=0
		while `retry'==1 &`tryct'<100 {
			local ++tryct
			local inpath "`path'progress.txt"
			local url "https://`center'.qualtrics.com/API/v3/responseexports/"
			!curl -H "`apiheader'" "`url'`request'" -o "`inpath'"
			clear
			mata: input = cat(`"`inpath'"')	
			getmata input
			gen status=regexs(1) if regexm(input, `""status":"(.+)"},"m"')
			cap drop file
			if `"`=status[1]'"'==`"complete"' {
				local retry=0
				gen file=regexs(1) if regexm(input, `""file":"(.+)","s"')
			}
			if `tryct' == 100 {
				if `restoredata' == 1 qui use	`orginal_data', clear
				set linesize `original_lines'
				di as error `"Qualtrics API not producing file. Check your token and data center or your password"'
				di as error `"On occasion, the Qualtrics API does not respond reliably, if you have already checked your password or token and data center, try again in little while"'
				error 6   	
			}
		}	
		local file `"`=file[1]'"'
		local inpath "`path'responses.zip"
		!curl -X GET -H "`headercont'" -H "`apiheader'" "`file'" -o "`inpath'"
	} // end if curl
	local inpath "`path'responses.zip"
	qui cd `"`path'"'
	qui unzipfile `"`inpath'"', replace //unzip file
	cap rm `"`path'reqfile.txt"'
	cap rm `"`path'progress.txt"'
	cap rm `"`path'responses.zip"'
	di as smcl `"CLICK TO OPEN FOLDER: {browse `"`path'"'}"'
	
	if `"`dta'"'==`""' {
		cap { 
			timer off 13
			qui timer list 13
			local runtime `"`r(t13)'"'
			return local runtime=`"`runtime'"'
		}
	}
*******************************END Download Survey to csv**********************************************************
**************************************Convert to DTA and apply labels, etc*********************************************
	if `"`dta'"'!=`""' {
		cap rm "`path'survey.txt" //Requesting download of all survey data in json, will use this to get csv name, and value labels, stems for labels
		local inpath "`path'survey.txt"
		local url "https://`center'.qualtrics.com/API/v3/surveys/`surveyid'"
		if `"`method'"'==`"curl"' {
			!curl -H "`apiheader'" "`url'" -o "`inpath'" 
		}
		if `"`method'"'==`"wget64"' {
			!wget64  --header="`apiheader'" "`url'" -O "`inpath'" 
		}
		mata: input = cat(`"`inpath'"') //importing for name of survey
		clear
		mata: input = cat(`"`inpath'"')
		getmata input
		qui gen name=regexs(1) if regexm(input,`"name":"(.+)","ownerId"')
		local file_name `"`=name[1]'"'
		qui import delimited "`upath'`file_name'.csv", varn(1) case(lower) clear
		if `"`clean'"'==`""' { //If clean option not selected just save the converted data and exit
			sa `"`dta'"', replace
			*cap rm "`path'survey.txt"
			cap { 
				timer off 13
				qui timer list 13
				local runtime `"`r(t13)'"'
				return local runtime=`"`runtime'"'
			}
			if `"`preserve'"' != "" qui use `orginal_data', clear
			set linesize `original_lines'
			exit
		}
		tempfile conv
		qui sa `conv'
		qui {
			clear
			mata: input = cat(`"`inpath'"')	 //reimporting the survey data
			getmata input
			qui count
			if `r(N)'>1 { //Usually the json is all put in one line of code, but sometimes a newline character, probably in the survey text, causes it to be split, putting it back
				forvalues i=2/`r(N)' {
					qui qui replace input=input[1]+input[`i'] in 1
				}	
			}	
			keep in 1
			replace input=regexr(input,`"\\n"',"")
			split input, p("QID")
			drop input
			gen n=1
			reshape long input, i(n) j(line)
			sum line if regexm(input,`""exportColumnMap""')
			assert `r(N)'==1
			drop if line>`r(mean)'
			replace input=regexr(input,`""exportColumnMap.+""',"")
			drop in 1
			count if regexm(input,`""choices""')
			gen subqs=1 if regexm(input,`""subQuestions""')|regexm(input,`""type":"MC","selector":"MA"')|regexm(input,`""type":"RO","selector"')|regexm(input,`""type":"CS","selector"')|regexm(input,`""type":"Matrix","selector"')
			gen choices=regexs(0) if regexm(input,`""choices.+""')
			replace choices="" if regexm(input,`""type":"MC","selector":"MA"')
			gen checkboxes=1 if regexm(input,`""type":"MC","selector":"MA"')
			replace choices="" if regexm(input,`""type":"RO","')
			gen rank_order=1 if regexm(input,`""type":"RO","')
			gen constant_sum=1 if regexm(input,`""type":"CS","')
			gen matrix_qs = 1 if regexm(input,`""type":"Matrix","')

			split choices, p(`""recode""')
			drop choices
			cap drop qid
			gen qid=regexs(0) if regexm(input,"^[0-9]+")
			replace qid="QID"+qid
			local value_ct=0
			ds choices*
			foreach ch in `r(varlist)' {
				local ++value_ct
				gen num`value_ct'=regexs(0) if regexm(`ch',`"[0-9]+"')
				gen choicetext`value_ct'=regexs(1) if regexm(`ch',`"choiceText":"(.+)","')
			}
			gen value_label="cap label define "+qid if !mi(choicetext1)
			ds num*
			foreach v in `r(varlist)' {
				if regexm(`"`v'"',"[0-9]") {
					local number=regexs(0)
				}
				replace value_label=value_label+" "+num`number'+`" ""'+choicetext`number'+`"" "' if !mi(choicetext`number')
			}
			replace value_label="" if regexm(value_label,"imageDescription")
			list value_label
			drop num* choicetext* choices*

			cap drop stem
			gen stem=regexs(1) if regexm(input,`"questionText":"(.+)",".+,"subQuestions"')
			replace stem=regexs(1) if regexm(input,`""type":"MC","selector":"MA.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"Matrix","selector":".+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"RO",.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"CS",.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"SBS",.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"TE",.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"Slider",.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"PGR",.+questionText":"(.+)","questionLabel"')
			replace stem=regexs(1) if regexm(input,`""type":"HeatMap",.+questionText":"(.+)","questionLabel"')
			gen subs=regexr(input,`"choices":.+"',"") if subqs==1&checkboxes!=1
			replace subs=input if subqs==1&(checkboxes==1|rank_order==1|constant_sum==1) //matrix_qs
			count if !mi(subs)
			local hasubqs `r(N)'
			if `hasubqs'>0 {
				split subs,p("recode")
				
				drop subs
				ds subs*
				local num=0
				foreach s in `r(varlist)' {
					if regexm(`"`s'"',"[0-9]+") {
						local tnum=regexs(0)
					}
					if `tnum'>`num' local num `tnum'
				}	

				di `tnum'
				forvalues s=`tnum'(-1)2 {
					local prior=`s'-1
					gen subqn`s'=regexs(1) if regexm(subs`prior',`""([0-9]+)":{"$"')
				}
				drop n line
				gen sort=_n
				bysort qid: gen N=_N
				qui sum N
				if `r(max)'>1 {
					egen keep=rownonmiss(value_label stem subs*), strok
					
					bysort qid (keep): keep if _N==_n
					drop keep

				}
				sort sort 
				drop sort N
				reshape long subs subqn, i(qid) j(qnum)
				gen subqt=regexs(1) if regexm(subs,`"choiceText":"(.+)","image"')
				replace subqt=regexs(1) if regexm(subs,`"choiceText":"(.+)","')&mi(subqt)
				*gen subqt=regexs(1) if regexm(subs,`"choiceText":"(.+)","')
				drop if regexm(subs,"subQuestions")	
				drop subs qnum
			}	
			cap drop question_name
			gen question_name=qid
			if `hasubqs'>0 replace question_name=question_name+`"_"'+subqn if !mi(subqn)
			replace question_name=question_name+`"_TEXT"' if regexm(input,`"type":"TE""')
			duplicates drop
			if `hasubqs'>0 drop if mi(subqt)&subqs==1
			gen quest_text=regexs(1) if regexm(input,`"questionText":"(.+)","questionLabel"')
			if `hasubqs'>0 replace quest_text=subqt if !mi(subqt)
			tempfile metan 
			sa `metan'
			use `conv' in 2, clear	
			set obs `=_N+1'
			foreach i of varlist * {
				replace `i'=`"`i'"' in 2
			}	
			qui sxpose, clear
			qui replace _var1=subinstr(_var1,`"{'ImportId': '"',"",.)
			qui replace _var1=subinstr(_var1,`"'}"',"",.)
			qui replace _var1=subinstr(_var1,`"_"',"-",.)
			qui split _var1, p("-")
			qui rename _var11 question
			qui rename _var12 subquest_num
			qui replace subquest_num="" if subquest_num=="TEXT"
			qui replace _var1=subinstr(_var1,"-","_",.)
			qui count
			local renct `r(N)'
			forvalues i=1/`renct' {
				local rct`i'
				local rct`i' `"replace question_name=`"`=_var2[`i']'"' if question_name==`"`=_var1[`i']'"'"'
			}
			use `metan', clear
			forvalues i=1/`renct' {
				qui `rct`i''
			}	
			ds, has(type string)
			foreach v in `r(varlist)' {
				while 1==1 {	
					gen start=strpos(`v',"<")
					qui sum start 
					if `r(mean)'==0 {
						drop start
						continue, break
					}
					gen end=strpos(`v',">")
					gen remove=substr(`v',start,end-start+1)
					replace `v'=subinstr(`v',remove,"",1)
					drop end start remove
				}	
				replace `v'=regexr(`v',`"\\n"'," ")
			}
			cap drop n
			cap drop line
			qui gen n=_n
			local value_lab_ct=0
			qui levelsof qid if !mi(value_label), local(idlevs)
			foreach qid of local idlevs {
				local ++value_lab_ct
				local val_lab`value_lab_ct'
				local val_lab_app`value_lab_ct'
				qui sum n if qid==`"`qid'"' 
				local val_lab`value_lab_ct' `"cap label define `qid' `=value_label[`r(min)']', replace"'
				qui levelsof question_name if qid==`"`qid'"', clean
				local val_lab_app`value_lab_ct' `"cap label values `r(levels)' `qid'"'
			}	
			count
			local varct `r(N)'
			forvalues i=1/`varct' {
				local qtext`i'
				local qtext`i' `"cap char `=question_name[`i']'[stem] `"`=stem[`i']'"'"'
				local qlab`i' 
				local qlab`i' `"cap label variable `=question_name[`i']' `"`=quest_text[`i']'"'"'
				local qlabc`i' 
				local qlabc`i' `"cap char `=question_name[`i']'[full_text] `"`=quest_text[`i']'"'"'
			}
			use `conv', clear
			foreach v of varlist * {
				cap label variable `v' `"`=`v'[1]'"' 
			}
			drop in 1/2
			qui destring *, replace
			foreach v of varlist * {
				local ilist: char `v'[]
				foreach i in `ilist' {
					char `v'[`i']
				}
			}
			
			forvalues i=1/`varct' {
				`qlabc`i''
				`qlab`i''
				`qtext`i''
			}
			forvalues i=1/`value_lab_ct' {
				`val_lab`i''
				`val_lab_app`i''
			}
		}
		sa `"`dta'"', replace //Save file
		*cap rm `"`inpath'"' //remove survey file
		di as smcl `"CLICK TO OPEN FOLDER: {browse `"`path'"'}"'
		if `"`relab'"'!="" { //List out labels so can modify manually
			se linesize 255
			forvalues i=1/`varct' {
				di `"`qlab`i''"'
			}
		}	
		if `"`revallab'"'!="" { //List out 
			forvalues i=1/`value_lab_ct' {
				se linesize 255
				di `"`val_lab`i''"'
				di `"`val_lab_app`i''"'
			}	

		}	
	}	
}				
cap { 
	timer off 13
	qui timer list 13
	local runtime `"`r(t13)'"'
	return local runtime=`"`runtime'"'
}
if `"`preserve'"' != "" qui use	`orginal_data', clear
end