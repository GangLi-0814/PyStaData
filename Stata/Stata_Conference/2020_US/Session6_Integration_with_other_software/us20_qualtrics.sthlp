{smcl}
{hline}
help for {cmd:qualtrics} {right:v2.0  March 2020}
{hline}

{title:Title}

{pstd}{hi:qualtrics} {hline 2} List, download, and clean surveys from the Qualtrics API

{marker syntax}{...}
{title:Syntax}
{hline}

{pstd}
    {cmd:qualtrics set}, [{it:set_options}] Set a password to use instead of the token and data center each call

{pstd}
    {cmd:qualtrics list}, [{it:list_options}] List surveys associated with your account, filter results

{pstd}
    {cmd:qualtrics get}, [{it:get_options}] Download survey, convert to .dta and clean

{hline}
{synoptset 25 tabbed}{...}
{marker setopts}{col 5}{help qualtrics##setoptions:{it:set_options}}{col 32}Description
{synoptline}
{synopt:{opth t:oken(strings:string)}}Qualtrics API token
    {p_end}
{synopt:{opth c:enter(strings:string)}}Data center used for your Qualtrics account
    {p_end}
{synopt:{opth p:assword(strings:string)}}Password to encode and decode Qualtrics token and data center
    {p_end}
{synopt:{opth u:ser(strings:string)}}Specify a user to pair with {ul:p}assword (optional)
    {p_end}
{synoptline}

{synoptset 25 tabbed}{...}
{marker listopts}{col 5}{help qualtrics##listoptions:{it:list_options}}{col 32}Description
{synoptline}
{synopt:{opth m:atch(strings:string)}}Return survey names matching a regular expression
    {p_end}
{synopt:{opth a:ctive(strings:string)}}Return only active or inactive surveys surveys
    {p_end}
{synopt:{opt modr:ange(MDY:MDY)}}Return only surveys last modified in a date range
    {p_end}
{synopt:{opt creater:ange(MDY:MDY)}}Return only surveys created in a date range
    {p_end}
{synopt:{opth t:oken(strings:string)}}Required if not using a set {ul:p}assword
    {p_end}
{synopt:{opth c:enter(strings:string)}}Required if not using a set {ul:p}assword
    {p_end}
{synopt:{opth p:assword(strings:string)}}Required if not specifying {ul:t}oken and {ul:c}enter
    {p_end}
{synopt:{opth u:ser(strings:string)}}User paired with {ul:p}assword (optional, if {ul:p}assword not set with {ul:u}ser)
    {p_end}
{synoptline}

{synoptset 25 tabbed}{...}
{marker getopts}{col 5}{help qualtrics##getoptions:{it:get_options}}{col 32}Description
{synoptline}
{synopt:{opth id:(strings:string)}}Qualtrics survey ID (can display with {cmd:qualtrics list})
    {p_end}
{synopt:{opth csv:(strings:string)}}Folder to save CSV (file is named as it is in Qualtrics)
    {p_end}
{synopt:{opth dta:(strings:string)}}File name and folder path to save .dta
    {p_end}
{synopt:{opt val:uelabs}}Request file with value labels instead of numeric codes (not compatible with {ul:cl}ean)
    {p_end}
{synopt:{opt cl:ean}}Apply variable and value labels, store item information in characteristics (not compatible with {ul:val}uelabs)
    {p_end}
{synopt:{opt relab:}}Display label variable commands to make manual adjustments (must use {ul:cl}ean)
    {p_end}
{synopt:{opt reval:lab}}Display label values commands to make manual adjustments (must use {ul:cl}ean)
    {p_end}
{synopt:{opt pre:serve}}Restore current dataset (rather than loading downloaded file)
    {p_end}
{synopt:{opth t:oken(strings:string)}}Required if not using a set {ul:p}assword
    {p_end}
{synopt:{opth c:enter(strings:string)}}Required if not using a set {ul:p}assword
    {p_end}
{synopt:{opth p:assword(strings:string)}}Required if not specifying {ul:t}oken and {ul:c}enter
    {p_end}
{synopt:{opth u:ser(strings:string)}}User paired with password (optional, if {ul:p}assword not set with {ul:u}ser)
    {p_end}
{synoptline}
{marker description}{...}
{title:Description}

{pstd}
{cmd:qualtrics} provides tools to list, download, convert, and clean Qualtrics surveys using the Qualtrics API.
{cmd:qualtrics list} displays surveys associated with the users account including the survey id (required to download), the creation time, modified time, and whether the survey is active.
{cmd:qualtrics get} downloads the .csv version of the survey, and then optionally converts it to .dta, and applies variable and value labels.
It also stores other item information, including question stems, in variable {help char:characteristics}.
{cmd:qualtrics set} allows users to set a password (and optional user name) which stores the Qualtrics data center and encrypts and stores the Qualtrics token in a text file in the user's {help adopath:personal .ado path}.
Users may either specify their Qualtrics token and data center each time {cmd:qualtrics list} or {cmd:qualtrics get} is called or use {cmd:qualtrics set} and then provide the password for each call.
{cmd:qualtrics} requires a cURL installation that can be called by Stata with the {cmd:shell(!)} command.

{marker setoptions}{...}
{title:qualtrics set}

{pstd}
{cmd:qualtrics set} is used to set up your token and data center so you do not need to specify them each time you run a qualtrics command.
It is not required that you set qualtrics, you may instead specify the {ul:t}oken and {ul:c}enter each time, but is is not reccomended, especially if sharing syntax with outside organizations who should not have access to your token.

{phang}
{opth t:oken(strings:string)} is used to enter your qualtrics token so that it can be encrypted and saved to a text file in your personal ado path to be read in on subsequent {cmd:qualtrics list} and {cmd:qualtrics get} calls. 
To find your API token, log in to your Qualtrics account, and navigate to account setting by clicking on the icon in the upper right corner. 
Click on Qualtrics IDs on the top bar, your token is listed (or can be generated) under the API section.
{bf:{ul:Important Note:}} Your token can be used to edit and delete surveys and survey responses. 
A bad actor could do considerable harm with it, so be sure not to share or expose it, and it is wise to encode it using {cmd:qualtrics set}.

{phang}
{opth c:enter(strings:string)} is used to enter your qualtrics data center so that it can be saved to a text file in your personal .ado path to be read in on subsequent {cmd:qualtrics list} and {cmd:qualtrics get} calls. 
To find your data center, log in to your Qualtrics account, and examine the url. 
The url will look something like "yourorgname.{ul:datacenter}.qualtrics.com." 
It will be something like co1, az1, or ca1.

{phang}
{opth p:assword(strings:string)} is a password you select. The password is used to encrypt your qualtrics token, and is required to decrypt it. It can include most any ASCII text except the left tick (`) used to define locals. 
Once you set qualtrics once, you should not need to do so again, unless you delete the file containing the information. If you forget your password, you can always {cmd:qualtrics set} again (and enter your token and data center again).

{phang}
{opth u:ser(strings:string)} is an optional user name you can pair with a password. You might want to do so if you have more than one Qualtrics account and need to store your token and data center separately. 
You may also want to do so if you have multiple users who share the same .ado path and would like to use different passwords. 
If you {cmd:qualtrics set} with the {ul:u}ser option you must continue to specify the user in your {cmd:qualtrics list} and {cmd:qualtrics get} calls.


{marker listoptions}{...}
{title:qualtrics list}

{pstd}
{cmd:qualtrics list} lists the surveys associated with the API token provided, and can filter the list in several ways. 

{phang}
{opth m:atch(strings:string)} is used to limit the surveys {cmd:qualtrics list} returns.
{cmd:qualtrics list} will only return surveys whose survey name matches the regular expression string entered in this option.
Note that you will have to use a \ before ()[].+*?-|&^$ if your survey name includes a literal regular expression notation.
For example, to return surveys that match "Fall 2020 Survey (version 1)", you would type something like m(2020 Survey \(version 1\)).

{phang}
{opth a:ctive(strings:string)} is used to return either active or inactive surveys as defined by Qualtrics.
Entering "true" will return active surveys only, and "false" will return inactive surveys only.

{phang}
{opt modr:ange(start MDY:end MDY)} is used to return surveys which were last modified in a date range. The required format is modr(month date year:month date year) with the start date first and the end date second.
The start and dates must be separated by a colon(:) and be in MDY format.
Any version including four-digit years which the {help date(): date(XXX,"MDY")} can interpret is acceptable.

{phang}
{opt creater:ange(start MDY:end MDY)} is used to return surveys which were created in a date range. The required format is creater(month date year:month date year) with the start date first and the end date second.
The start and dates must be separated by a colon(:) and be in MDY format.
Any version including four-digit years which the {help date(): date(XXX,"MDY")} can interpret is acceptable.

{phang}
{opth t:oken(strings:string)} is used to enter your qualtrics token if you opt not to use {cmd:qualtrics set}.
See the documentation in {help qualtrics##setoptions:{it:set options}} for instructions on finding your token.
{bf:{ul:Important Note:}} Your token can be used to edit and delete surveys and survey responses.
A bad actor could do considerable harm with it, so be sure not to share or expose it, and it is wise to encode it using {cmd:qualtrics set}.

{phang}
{opth c:enter(strings:string)} is used to enter your qualtrics data center if you opt not to use {cmd:qualtrics set}.
See the documentation in {help qualtrics##setoptions:{it:set options}} for instructions on finding your data center.

{phang}
{opth p:assword(strings:string)} is the password you used in a previous {cmd:qualtrics set} command.

{phang}
{opth u:ser(strings:string)} is an optional user name you may have paired with a password in a previous {cmd:qualtrics set} command.


{marker getoptions}{...}
{title:qualtrics get}

{pstd}
{cmd:qualtrics get} downloads, converts and cleans designated survey.

{phang}
{opth id:(strings:string)} is used to specify the Qualtrics survey ID to be downloaded.
IDs can be found by using a {cmd:qualtrics list} command.

{phang}
{opth csv:(strings:string)} is used to select the folder to save the .csv survey downloaded.
{ul:Do not} provide a file name, only a folder path. 
The file is named by Qualtrics.
This option is required.

{phang}
{opth dta:(strings:string)} is used to specify the location and name to use saving a converted .dta file.
Unlike the csv option, a file name should be included.
This option must be included if selecting the {ul:cl}ean, relab, or {ul:reval}lab options.

{phang}
{opt val:uelabs} is used to request value labels, rather than numeric codes.
The resulting .csv will have strings with the response option text.
This option may not be combined with the {ul:cl}ean option.

{phang}
{opt cl:ean} is used to download the survey meta-data and apply variable labels and value labels to the variables.
It will also store the question stems and labels in the variable {help char:characteristics}.
{ul:Note:} Qualtrics has numerous question formats and this information is often stored differently.
For this reason the clean function may not catch value labels for all types of questions, or may capture labels which are not as informative as one might like.

{phang}
{opt relab:} is used display code which can be pasted into a .do file to make manual adjustments to variable labels.
This can be useful if variable labels are truncated or otherwise need to be edited.
This information is also stored in variable {help char:characteristics}, which can also be used to adjust labels
The {ul:cl}ean option must be selected if using this option.

{phang}
{opt reval:lab} is used display code which can be pasted into a .do file to make manual adjustments to value labels.
This can be useful if value labels are truncated or otherwise need to be edited.
The {ul:cl}ean option must be selected if using this option.

{phang}
{opt pre:serve} is used to restore the dataset in memory when {cmd:qualtrics get} is run.
The default is to load the downloaded dataset.

{phang}
{opth t:oken(strings:string)} is used to enter your qualtrics token if you opt not to use {cmd:qualtrics set}.
See the documentation in {help qualtrics##setoptions:{it:set options}} for instructions on finding your token.
{bf:{ul:Important Note:}} Your token can be used to edit and delete surveys and survey responses.
A bad actor could do considerable harm with it, so be sure not to share or expose it, and it is wise to encode it using {cmd:qualtrics set}.

{phang}
{opth c:enter(strings:string)} is used to enter your qualtrics data center if you opt not to use {cmd:qualtrics set}.
See the documentation in {help qualtrics##setoptions:{it:set options}} for instructions on finding your data center.

{phang}
{opth p:assword(strings:string)} is the password you used in a previous {cmd:qualtrics set} command.

{phang}
{opth u:ser(strings:string)} is an optional user name you may have paired with a password in a previous {cmd:qualtrics set} command.


{marker setexamples}{...}
{title:qualtrics set examples}
An example not specifying a user.
	qualtrics set, t(`"QualtricsAPITokenHere"') c(`"co1"') password(ApassW0rd)

Specifying a user as well.
	qualtrics set, t(`"QualtricsAPITokenHere"') c(`"az1"') password(ApassW0rd) u(danial)

{marker listexamples}{...}
{title:qualtrics list examples}

List all surveys using the password.
	qualtrics list, password(ApassW0rd)

List all surveys using the password and user.
	qualtrics list, p(ApassW0rd) u(danial)

List all surveys using the token and data center instead of the password.
	qualtrics list, t(`"QualtricsAPITokenHere"') c(`"co1"')

List surveys whose name includes "Fall 2020".
	qualtrics list, password(ApassW0rd) m(Fall 2020)

List surveys whose name includes "Fall 2020", "Fall 2019" or "Fall 2018".
	qualtrics list, password(ApassW0rd) m(Fall 20[1-2][890])

List surveys whose name includes "Fall 2020" and last modified between April 20th 2020 and December 15th 2020.
	qualtrics list, password(ApassW0rd) m(Fall 2020) modr(Apr 20 2020:Dec 15 2020)

List active surveys created between April 20th 2020 and December 15th 2020.
	qualtrics list, password(ApassW0rd) a(true) creater(4/20/2020:12/15/2020)

{marker getexamples}{...}
{title:qualtrics get examples}

Get a csv file of a survey using the password
	qualtrics get, id(`"SV_XYXYXYXYX"') csv(`"C:/Users/dhoepfner/Desktop/"') password(ApassW0rd)

Get a survey and convert to stata using the token and data center
	qualtrics get, id(`"SV_XYXYXYXYX"') t(`"QualtricsAPITokenHere"') c(`"az1"') ///
	csv(`"C:/Users/dhoepfner/Desktop/"') dta(`"C:\Users\dhoepfner\Desktop\testdata.dta"')

Get a survey, convert and clean it, output text to modify variable and value labels
	qualtrics get, id(`"SV_XYXYXYXYX"') password(ApassW0rd) csv(`"C:/Users/dhoepfner/Desktop/"') ///
	dta(`"C:\Users\dhoepfner\Desktop\testdata.dta"') clean relab reval

{marker author}{...}
{title:Author}
Danial Hoepfner, Gibson Consulting Group Inc., dhoepfner@gibsonconsult.com or danial.hoepfner@gmail.com
