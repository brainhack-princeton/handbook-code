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
    "/jukebox/hasson/singularity/heudiconv/heudiconv.sqsh "
    "heudiconv -f reproin --subject {2} --ses {3} --bids --locator /home/bids --files "
    "/home/dicom/{1}".format(data_dir, subj_dir.split('/')[-1], subj_id, session_id),
    shell=True)


# IF YOU ARE IN THE MIDDLE OF AN EXISTING STUDY AND YOUR PROGRAM CARD HAS CHANGED, 
# YOU SHOULD REPLACE -o /home/bids WITH THE --LOCATOR FLAG BELOW AND DIRECT IT TO YOUR CURRENT DIRECTORY STRUCTURE:

# --locator /home/bids/Norman/McDevitt/7137_viodiff

# EXAMPLE:

# run("singularity exec --cleanenv --bind {0}:/home "
#     "/jukebox/hasson/singularity/heudiconv/heudiconv.sqsh "
#     "heudiconv -f reproin --subject {2} --ses {3} --bids --locator /home/bids/Norman/McDevitt/7137_viodiff --files "
#     "/home/conquest/{1}".format(fmri_dir, subj_dir.split('/')[-1], subj_id, session_id),
#     shell=True)