#! /bin/bash

# This script will cleanup files to make them BIDS compatible. 
# The goal here is to fix any errors and/or warnings from the BIDS validator. 

set -e #stop immediately if error occurs

# LOAD IN GLOBAL VARIABLES
source globals.sh   

subj=$1

# delete scout images
find $bids_dir/sub-$subj -name "*scout*" -delete
# put in call to remove dubplicate date file

# delete duplicate runs if you run multiple -- OPTIONAL FOR YOU
find $bids_dir/sub-$subj -name "*dup*" -delete

# if you took AP/PA fieldmaps, here's an example on modifying the output to be bids-compatible
# MAKE SURE YOU MODIFY THE FILENAMES TO MATCH YOUR STUDY'S FILENAMES 

# change _magnitude to _epi in filename for fieldmap niftis and jsons:
mv $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-AP_magnitude.json $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-AP_epi.json
mv $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-AP_magnitude.nii.gz $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-AP_epi.nii.gz
mv $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-PA_magnitude.json $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-PA_epi.json
mv $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-PA_magnitude.nii.gz $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-PA_epi.nii.gz

# If you want fmriprep to use your fieldmaps for susceptibility distortion correction, 
# you need to tell fmriprep which fieldmaps to use to correct each functional run. 

# To do this, you add an IntendedFor line to fieldmap json files. We provide an example below,
# but keep in mind you need to EDIT THIS FOR YOUR SPECIFIC STUDY (e.g., number of runs, task names, etc.)

# SESSION 1: list all run filenames
beginning='"IntendedFor": ['
run1="\""ses-01/func/sub-${subj}_ses-01_task-study_run-01_bold.nii.gz"\","
run2="\""ses-01/func/sub-${subj}_ses-01_task-study_run-02_bold.nii.gz"\","
run3="\""ses-01/func/sub-${subj}_ses-01_task-study_run-03_bold.nii.gz"\","
run4="\""ses-01/func/sub-${subj}_ses-01_task-study_run-04_bold.nii.gz"\","
run5="\""ses-01/func/sub-${subj}_ses-01_task-study_run-05_bold.nii.gz"\","
run6="\""ses-01/func/sub-${subj}_ses-01_task-study_run-06_bold.nii.gz"\""
end="],"

insert="${beginning}${run1} ${run2} ${run3} ${run4} ${run5} ${run6}${end}"

# insert IntendedFor field after line 35 (i.e., it becomes the new line 36)
sed -i "35 a \ \ ${insert}" $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-AP_epi.json
sed -i "35 a \ \ ${insert}" $bids_dir/sub-$subj/ses-01/fmap/sub-${subj}_ses-01_dir-PA_epi.json

# SESSION 2: list all run filenames
run1="\""ses-02/func/sub-${subj}_ses-02_task-postscenes_run-01_bold.nii.gz"\","
run2="\""ses-02/func/sub-${subj}_ses-02_task-familiarization_run-01_bold.nii.gz"\","
run3="\""ses-02/func/sub-${subj}_ses-02_task-reward_run-01_bold.nii.gz"\","
run4="\""ses-02/func/sub-${subj}_ses-02_task-reward_run-02_bold.nii.gz"\","
run5="\""ses-02/func/sub-${subj}_ses-02_task-decision_run-01_bold.nii.gz"\","
run6="\""ses-02/func/sub-${subj}_ses-02_task-familiarization_run-02_bold.nii.gz"\","
run7="\""ses-02/func/sub-${subj}_ses-02_task-reward_run-03_bold.nii.gz"\","
run8="\""ses-02/func/sub-${subj}_ses-02_task-reward_run-04_bold.nii.gz"\","
run9="\""ses-02/func/sub-${subj}_ses-02_task-decision_run-02_bold.nii.gz"\","
run10="\""ses-02/func/sub-${subj}_ses-02_task-postfaces_run-01_bold.nii.gz"\""

insert="${beginning}${run1} ${run2} ${run3} ${run4} ${run5} ${run6} ${run7} ${run8} ${run9} ${run10}${end}"

sed -i "35 a \ \ ${insert}" $bids_dir/sub-$subj/ses-02/fmap/sub-${subj}_ses-02_dir-AP_epi.json
sed -i "35 a \ \ ${insert}" $bids_dir/sub-$subj/ses-02/fmap/sub-${subj}_ses-02_dir-PA_epi.json