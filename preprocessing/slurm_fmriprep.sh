#!/bin/bash

# Run from BIDS code/preprocessing directory: sbatch slurm_fmriprep.sh

# Name of job?
#SBATCH --job-name=fmriprep

# Set partition
#SBATCH --partition=all

# How long is job?
#SBATCH -t 18:00:00

# Set array to be your subject number
#SBATCH --array=001, 002, 003

# Where to output log files? The log file will be in the format of the job ID_array number
# make sure this logs directory exists!! otherwise the script won't run
#SBATCH --output='../../data/bids/derivatives/fmriprep/logs/fmriprep-%A_%a.log'

# How much memory to allocate (in MB)?
#SBATCH --cpus-per-task=8 --mem-per-cpu=20000

# Update with your email 
#SBATCH --mail-user=YOUREMAIL@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# Remove modules because Singularity shouldn't need them
echo "Purging modules"
module purge

# Print job submission info
echo "Slurm job ID: " $SLURM_JOB_ID
date

# Set subject ID based on array index
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID

# Run fMRIPrep script with participant argument
echo "Running fMRIPrep on sub-$subj"

./run_fmriprep.sh $subj

echo "Finished running fMRIPrep on sub-$subj"
date

# Deface post-fmriprep T1w template image
echo "Defacing preprocessed T1w for sub-$subj"

./deface_template.sh $subj

echo "Finished defacing T1w"
