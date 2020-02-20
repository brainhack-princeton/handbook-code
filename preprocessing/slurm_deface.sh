#!/bin/bash

# Name of job?
#SBATCH --job-name=deface

# Set array to be your subject number
#SBATCH --array=001

# Where to output log files?
# make sure this logs directory exists!! otherwise the script won't run
#SBATCH --output='../../data/bids/derivatives/deface/logs/deface-%A_%a.log'

# Set partition
#SBATCH --partition=all

# How long is job?
#SBATCH -t 00:30:00

# How much memory to allocate (in MB)?
#SBATCH --cpus-per-task=8 --mem-per-cpu=14000

# Update with your email 
#SBATCH --mail-user=YOUREMAIL@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# Print job submission info
echo "Slurm job ID: " $SLURM_JOB_ID
date

# # Set subject ID based on array index
printf -v bids_id "%03d" $SLURM_ARRAY_TASK_ID

# Set session number
session=1
printf -v ses_id "%02d" $session

# Run deface script for this subject and this session
echo "Running PYDEFACE on sub-$bids_id, ses-$ses_id"

./deface.sh $bids_id $ses_id

echo "Finished running PYDEFACE on sub-$bids_id, ses-$ses_id"
date

# # If you have multiple sessions per subject, then run for session 2, etc. 
# session=2
# printf -v ses_id "%02d" $session

# # Run deface script for this subject and this session
# echo "Running PYDEFACE on sub-$bids_id, ses-$ses_id"

# ./deface.sh $bids_id $ses_id

# echo "Finished running PYDEFACE on sub-$bids_id, ses-$ses_id"
# date
