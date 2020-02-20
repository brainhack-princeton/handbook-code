#!/usr/bin/env python3
"""

M. Meshulam, 2017
create index file (run, number of TRs)
input: (1) path to input dataset (2) path to write output file
output: _index.csv file with number of TRs for each run within dataset (col1 = run, col2 = number of TRs)   
usage: ./number_of_files.py /mnt/bucket/dicom/conquest/Skyra-AWP45031/your_dataset/dcm /mnt/bucket/your_output_path

"""

import numpy as np
import pandas as pd
import sys
from os import listdir
from os.path import isfile, join, exists, isfile

# print out input parameters
path_to_dataset = str(sys.argv[1])
path_to_output = str(sys.argv[2])
input_subject = str(sys.argv[3])
input_session = sys.argv[4]

output_filename = input_subject + "_" + input_session + "_index.csv"

print ('Path to dataset: '+path_to_dataset)
print ('Path to output: '+path_to_output)
print ('Output filename: '+output_filename)
print (join(path_to_output,output_filename))

# find all files in this scan
scan_files = [f for f in listdir(path_to_dataset) if isfile(join(path_to_dataset, f))]
# get number of files in each run
temp = [int(str(f).split('-')[0]) for f in scan_files] 
numof_files_in_each_run = np.asarray([[x,temp.count(x)] for x in set(temp)]) 

#save index as csv file (col1 = run, col2 - number of TRs)    
pd.DataFrame(numof_files_in_each_run).to_csv(join(path_to_output,output_filename), index=False)

print ('Complete')


