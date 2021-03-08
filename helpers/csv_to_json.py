import pandas as pd
import argparse
import os
import re

parser = argparse.ArgumentParser(description = "Convert csv to json")
parser.add_argument("infile", help = "path to input csv file", type = str)
parser.add_argument("outfile", help = "path of output file", type = str)
parser.add_argument("-orient", help="to_json orient option", type=str, default='index')
args = parser.parse_args()

if not os.path.exists(args.infile):
    print("ERROR: Input csv file DNE")
    exit

raw = pd.read_csv(args.infile)
formatted_data = raw.to_json(orient = args.orient)
formatted_data = re.sub(r"null", '\"\"', formatted_data)

with open(args.outfile, 'w') as f:
    f.write(formatted_data)