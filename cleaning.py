#!/usr/bin/local/python

import csv
import os
import sys
from dbfpy import dbf


# Globals/Relative references

DIR = os.getcwd()
INPUT = DIR + "example-data/Price data from year 2003 to date/"
BASE_YEAR = 2003


def DBFtoCSV(filename):
	if filename.endswith('.DBF'):
	    
	    print "Converting %s to csv" % filename
	    csv_fn = filename[:-4]+ ".csv"
	    
	    with open(csv_fn,'wb') as csvfilename:
	        
	        in_db = dbf.Dbf(filename)
	        out_csv = csv.writer(csvfilename)
	        names = []
	        
	        for field in in_db.header.fields:
	            names.append(field.name)
	        
	        out_csv.writerow(names)
	        
	        for rec in in_db:
	            out_csv.writerow(rec.fieldData)
	        
	        in_db.close()
	        
	        print "Done..."
	
	else:
	  print "Filename does not end with .DBF"


for folder in os.listdir(INPUT):
	if folder!=".DS_Store" and folder[-4:]!="xlsx":
		for item in os.listdir(INPUT + folder):
			DBFtoCSV(INPUT + folder + "/" + item)



