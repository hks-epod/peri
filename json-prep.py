#!/usr/bin/local/python

import csv
import json
import os
import pprint

# Relative ref

DIR = os.getcwd()

# Converting csv to json

csvfile = open(DIR + "/example-data/Price data from year 2003 to date/alldata.csv", "r")

output = []

with open(DIR + "/example-data/Price data from year 2003 to date/alldata.csv") as csv_file:
    for prices in csv.DictReader(csv_file):

    	item = {}

    	item["item"] = prices["itm"]
    	item["regions"] = []

    	item["regions"].append({
    		"div": prices["div"],
    		"history": [{
    			"date": prices["date"],
    			"min": prices["pra"],
    			"max": prices["prb"]
    			}] # price-history closer
    		}) # regions closer

    	output.append(item)




output_json = json.dumps(output)

# Check

pp = pprint.PrettyPrinter(indent=4)
pp.pprint(output_json)