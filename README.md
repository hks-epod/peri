Commodity price tracking
=======

### Summary

September 2015. Visualizing commodity price data.


### Specs
* **Partner**: TBD
* **Start date**: Sep 2015
* **Status**: Converting .csv files into a .json. Building a prototype viz in `MetricsGraphics.js`.

### Notes
The `.dbf` files are in the following format:

SORTCOD | CTYP | DIV | DTE | WEK | ITM01 | PRA01 | PRB01 | ... | ITM35 | PRA35 | PRB35
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
int | int | int | yyyy-mm-dd | int | int | int | int | ... | int | int | int

where
* SORTCOD = ?
* CTYP = commodity type?
* DIV = geographic region/division?
* DTE = date
* WEK = ?
* ITM = the commodity
* PRA = min price
* PRB = max price

So we need to `reshape` it from wide to long. Final, desired output would be a JSON array of commodities, where each commodity is an object with date-price data.

```javascript
[
	{
		"item": 01
		"regions": [
			{
				"div": 01
				"history": [{ "date": 2003-08-01, "min": 10, "max": 11},...,{"date": 2015-09-22, "min": 12, "max": 13}]
			} //division closer			
		] //price-history across all divisions closer
	}, //item closer
	{
		"item": 02
		"regions": [
			{
				"div": 01
				"history": [{ "date": 2003-08-01, "min": 55, "max": 57},...,{"date": 2015-09-22, "min": 100, "max": 103}]
			} //division closer			
		] //price-history across all divisions closer
	} //item closer
]

```



### Resources
* [MetricsGraphics.js - Data visualization library](http://metricsgraphicsjs.org/)

### TODO

1. ~~Get `git` set up.~~
2. ~~Convert `.dbf` to `.csv`.~~
3. Does that nested JSON make sense?
4. Convert `.csv` into nested `.json`. 





