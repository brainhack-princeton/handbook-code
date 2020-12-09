#!/bin/bash

source globals.sh

singularity run --cleanenv \
    --bind $bids_dir:/bids \
    --bind $scratch_dir:/scratch \
    --bind /usr/people \
    /jukebox/hasson/singularity/mriqc/mriqc-v0.15.1.simg \
    --correct-slice-timing --modalities T1w bold \
    --no-sub \
    --nprocs 8 -w /scratch \
    /bids /bids/derivatives/mriqc group

