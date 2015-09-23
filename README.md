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

Currently:
```javascript
{
	"Bahawalpur": {
		"(item 1)": [{"date": x, "price": y},...,{"date": x, "price": y}],
		"(item 2)": [{"date": x, "price": y},...,{"date": x, "price": y}]
	},
	"D.G. Khan": { ... }
}
```

Goal:
```javascript
[
	{
	"region": "Bahawalpur",
	"items": [
		{"(item 1)": [[{"date": x, "price": y},...,{"date": x, "price": y}]},
		{"(item 2)": [[{"date": x, "price": y},...,{"date": x, "price": y}]},
		]
	}, {
	"region": "D.G. Khan",
	"items": [
		{"(item 1)": [[{"date": x, "price": y},...,{"date": x, "price": y}]},
		{"(item 2)": [[{"date": x, "price": y},...,{"date": x, "price": y}]},
		]
	}
]
```

### Resources
* [MetricsGraphics.js - Data visualization library](http://metricsgraphicsjs.org/)

### TODO

1. ~~Get `git` set up.~~
2. ~~Convert `.dbf` to `.csv`.~~ See `cleaning.py`.
3. ~~Does that nested JSON make sense?~~
4. ~~Convert `.csv` into nested `.json`.~~ See `json-prep.html` for the actual conversion.
5. First go at MetricsGraphics.js. 
6. Is the JSON in the right format for MetricsGraphics?
7. `alldata.json`: convert object into array of objects?
8. `alldata.json`: `"item": d.itm`?





