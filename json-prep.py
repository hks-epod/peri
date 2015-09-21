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

    	output.append({
    		 "item": prices["itm"],
    		 
    		 "div": []

    		 output["div"].append(prices["div"])

    		}) #item closer

        # output["item"] = prices["itm"]
        # output["div"] = prices["div"]
        
        # output["div"].append({
        # 	output["history"] = {}

        # 	output["history"].append(
        # 		output["date"] = prices["date"]
        # 		output["price"] = {}

        # 		output["price"].append({
        # 				output["min"] = prices["pra"]
        # 				output["max"] = prices["prb"]
        	# 		}) #date closer

        	# 	) #division's history closer

        	# }) #division object closer


output_json = json.dumps(output)

# Check

pp = pprint.PrettyPrinter(indent=4)
pp.pprint(output_json)