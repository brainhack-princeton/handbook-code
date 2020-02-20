#!/bin/bash

source globals.sh

singularity run --cleanenv \
    --bind $bids_dir:/home \
    /jukebox/hasson/singularity/mriqc/mriqc-v0.10.4.sqsh \
    --correct-slice-timing --modalities T1w bold \
    --no-sub \
    --nprocs 8 -w /home/derivatives/work \
    /home /home/derivatives/mriqc group
