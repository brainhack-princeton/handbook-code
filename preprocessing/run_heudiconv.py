#!/usr/bin/env python

# make sure anacondapy/5.3.1 is loaded before running (otherwise run will not be imported from subprocess)

from glob import glob
from os.path import exists, join
from sys import argv
from subprocess import run

subj_dir = argv[1]
subj_id = argv[2]
session_id = argv[3]
data_dir = argv[4]

print("Running heudiconv for subject {0} session {1}".format(subj_id, session_id))

run("singularity exec --cleanenv --bind {0}:/home "
    "/jukebox/hasson/singularity/heudiconv/heudiconv-v0.8.0.simg "
    "heudiconv -f reproin --subject {2} --ses {3} --bids --locator /home/bids --files "
    "/home/dicom/{1}".format(data_dir, subj_dir.split('/')[-1], subj_id, session_id),
    shell=True)


# NOTES:

# because of the --bind command, data_dir (as defined in globals.sh) is called /home within the singularity command
# --locator /home/bids is where is the output files will be saved
# /home/dicom/ is where HeuDiConv will look for the subj_dir containing the raw dicom files to input to HeuDiConv
