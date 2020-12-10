#! /bin/bash

module load anacondapy/5.3.1 #you can remove this line if you are working in your own conda environment

# 1. Edit wherever the dicoms get transferred on the scanner

#scanner_dir=/jukebox/dicom/conquest/Skyra-AWP45031/NormaL/2020 #Skyra
#scanner_dir=/jukebox/dicom/conquest/Prisma-MSTZ400D/NormaL/2020 #Prisma
scanner_dir=/jukebox/norman/pygers/conquest #Sample project data

# 2. Edit where your project directory is
project_dir=/jukebox/YOURLAB/USERNAME/YOURSTUDY

# 3. Edit where your scratch and work directories are located (note: make sure you have setup a work directory on scratch)
scratch_dir=/jukebox/scratch/USERNAME/work/YOURSTUDY
# scratch_dir=/jukebox/YOURLAB/USERNAME/YOURSTUDY/data/work

data_dir=$project_dir/data
bids_dir=$data_dir/bids
raw_dir=$data_dir/dicom #this is where I want the data from conquest to be copied into my study directory 
defaced_dir=$bids_dir/derivatives/deface #this is where defaced images will end up
scripts_dir=$project_dir/code/preprocessing #directory with my preprocessing scripts, including this one
