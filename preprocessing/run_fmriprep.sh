#!/bin/bash

source globals.sh

singularity run --cleanenv \
    --bind $project_dir:/home \
    /jukebox/hasson/singularity/fmriprep/fmriprep-v1.2.3.sqsh \
    --participant-label sub-$1 \
    --fs-license-file /home/code/preprocessing/license.txt \
    --no-submm-recon \
    --bold2t1w-dof 6 --nthreads 8 --omp-nthreads 8 \
    --output-space T1w template fsaverage6 \
    --template MNI152NLin2009cAsym \
    --write-graph --work-dir /home/data/bids/derivatives/work \
    /home/data/bids /home/data/bids/derivatives participant

 # many usage options
 # SEE HERE: https://fmriprep.readthedocs.io/en/stable/usage.html

 # To only run for a specific task, add -t flag. For example: 
 #  -t study \
 
 # If you have more than 2 T1w images, you may want to run with longitudinal flag: 
 # --longitudinal \

 # To ignore fieldmaps:
 # --ignore fieldmaps

 # To use fieldmap-less distortion correction:
 # --use-syn-sdc