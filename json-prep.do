* *************************************************************************************
* PROGRAM: json-prep.do
* PROGRAMMER: Angela Ambroz 
* DATE CREATED: 19 September 2015
* DATE MODIFIED: 
* PURPOSE: Prepping the PERI retail data into json.
* USES DATA: 
* CREATES DATA: 
* ***********************************************************************************

**	Codes	**

/* 
The following code is used throughout:

	(N/A)
	
*/


**	Preamble	**

clear *
set mem 512m
set matsize 800
set more off 
cap log c

**	References	**

if "`c(username)'"=="angelaambroz" {
	global	peri			"/Users/angelaambroz/Dropbox (Personal)/EPoD (Personal)/Data analytics/PERI"
	global	peridata		"$peri/example-data/Price data from year 2003 to date"
}
else {
	di as error	"Hello, `c(username)'. Please modify filepaths."
}

**	Log	**

local date: di %tdCCYY.NN.DD date(c(current_date),"DMY")

local cti = substr("`c(current_time)'", 1,5)
local cti: subinstr local cti ":" ".", all

log using "$peri/logs/`date'_Logged_at_`cti'_by_`c(username)'.log", replace


************************
*** Importing data	**
************************

//so much easier in python...
forval i=3/15 {
	local year = 2000 + `i'
	local files_`i' : dir "$peridata/Price_`year'" files "*.csv"
	
	//NOTE: APR03 is zero bytes, don't know why yet.
	
	foreach file in `files_`i'' {
		
		di as error "Now doing: `file'"
	
		insheet using "$peridata/Price_`year'/`file'", clear

		//NOTE: this isn't working for initial items (1-10?), which is weird
		//will worry about it later, since this is a demo/proof of concept
		reshape long itm pra prb, i(sortcod dte) j(test)

		g date = date(dte, "YMD")
		format date  %td

		keep sortcod date ctyp div wek itm pra prb
		drop if itm==.

		//average pra and prb, i guess. 
		egen avg = rowmean(pra prb)
		drop if avg<pra //(since i think prb is wrong in these cases)

		tempfile temp_`i'
		save `temp_`i'', replace		
	}
}

forval i=3/15 {
	append using `temp_`i''
}

save "$peridata/alldata", replace
outsheet using "$peridata/alldata.csv", c replace



