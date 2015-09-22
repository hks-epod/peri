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

#d ;
label define commodities
1	"WHEAT ATTA LOOSE(MILL)"
2	"WHEAT ATTA (THAILA)"
3	"ATTA(FAIR PRICE SHOP)"
4	"ATTA (IN OPEN MARKET)"
5	"WHEAT ATTA (THAILA)"
6	"WHEAT ATTA (THAILA)"
7	"GARLIC"
8	"GINGER"
9	"MAIDA"
10	"RAWA/SUJI"
11	"VEG. GHEE (LOOSE)"
12	"VEG. GHEE (TIN) GCP"
13	"VEG. GHEE (TIN) DALDA"
14	"BAISAN (GROUND GRAM)"
15	"RICE BASMATI"
16	"BROKEN BASMATI"
17	"RICE IRRI-6/IRRI-PAK"
18	"RICE"
19	"GRAM"
20	"GRAM DAL"
21	"MASOOR (WHOLE)"
22	"MASOOR (DAL)"
23	"MASH (WHOLE)"
24	"MASH DAL (UNWASHED)"
25	"MASH DAL (WASHED)"
26	"MOONG (WHOLE)"
27	"MOONG DAL (UNWASHED)"
28	"MOONG DAL (WASHED)"
29	"CHILLIES (GROUND)"
30	"SUGAR WHITE"
31	"SHAKKAR"
32	"GUR"
33	"ROCK SALT"
34	"ROCK SALT (CRUSHED)"
35	"DOUBLE ROTI (RCP)"
36	"DOUBLE ROTI (LOCAL)"
37	"TANORI ROTI"
38	"CHICKEN MEAT(BROILER)"
39	"CHICKEN MEAT (DESI)"
40	"MUTTON"
41	"BEEF"
42	"EGGS (FARMI)"
43	"MILK"
44	"POTATOES"
45	"ONIONS"
46	"SPINACH"
47	"TOMATOES"
48	"BRINJAL"
49	"BRINJAL (LONG)"
50	"BITTER GOURD"
51	"LADY FINGER"
52	"TINDA"
53	"ARVI"
54	"GHIA KADDU"
55	"CAULIFLOWER"
56	"TURNIP"
57	"CARROT"
58	"PEAS"
59	"RADISH"
60	"KEROSENE OIL"
61	"FIREWOOD"
62	"CURD"
63	"ELECTRIC BULB 100 W"
64	"LIFE BUOY"
65	"WASHING SOAP (707)"
66	"WASHING SOAP (SUFI)"
67	"MATCHES 50 STICKS"
68	"TEA (LIPTON/RICHBRU)"
69	"CIGARETTES(K-2)10 CGS"
70	"WHEAT ATTA LOOSE(CHAKKI)"
71	"COOKING OIL (TIN)PLANTA"
72	"DOUBLE ROTI DAWN/WONDER"
73	"CHICKEN ALIVE (BROILER)"
74	"MILK PACKED (HALEEB)"
75	"GHIA TORRI"
76	"LEMON"
77	"COCUMBER (KHEERA)"
78	"TEA (YELLOW LABLE)"
79	"VEG. GHEE (TIN)"
80	"APPLE  SUPERIOR QUALITY"
81	"APPLE  AVERAGE  QUALITY"
82	"BANANA"
83	"DATES"
84	"GUAVA"
85	"MILK POWDERED NIDO"
86	"COOKED BEEF PLATE"
87	"WHEAT"
88	"MUSTARED OIL"
89	"TEA PREPARED (SADA)"
;

#d ;
label define regions
1	"Bahawalpur"
2	"D. G. Khan"
3	"Faisalabad"
4	"Gujranwala"
5	"Lahore"
6	"Multan"
7	"Rawalpindi"
8	"Sarghodah"
9	"Sahiwal"
;

#d cr


label val itm commodities
label val div regions

save "$peridata/alldata", replace
outsheet using "$peridata/alldata.csv", c replace



