#!/bin/bash

source globals.sh

export SINGULARITYENV_TEMPLATEFLOW_HOME=/home/fmriprep/.cache/templateflow

singularity run --cleanenv \
    --bind $project_dir:/project \
    --bind $scratch_dir:/scratch \
    --bind /usr/people \
    --bind /jukebox/hasson/templateflow:/home/fmriprep/.cache/templateflow \
    /jukebox/hasson/singularity/fmriprep/fmriprep-v20.2.0.simg \
    --participant-label sub-$1 \
    --fs-license-file /project/code/preprocessing/license.txt \
    --no-submm-recon \
    --bold2t1w-dof 6 \
    --nthreads 8 --omp-nthreads 8 \
    --output-spaces T1w fsaverage:den-41k \
                    MNI152NLin2009cAsym:res-native \
    --write-graph --work-dir /scratch \
    /project/data/bids /project/data/bids/derivatives participant

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