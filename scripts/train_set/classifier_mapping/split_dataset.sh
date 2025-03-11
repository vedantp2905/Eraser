#!/bin/bash

model=${1}
# Store the project root directory
PROJECT_ROOT=$(pwd)

# Set base directories from project root
scriptDir=${PROJECT_ROOT}/src/classifier_mapping
saveDir=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/split_dataset

# Create save directory if it doesn't exist
mkdir -p ${saveDir}

# Path to the directory containing the CSV file
filePath=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/

python ${scriptDir}/split_dataset.py \
  --file_path ${filePath} \
  --layer 12 \
  --validation_size 0.1 \
  --validation_dataset_save_path ${saveDir}/validation/ \
  --train_dataset_save_path ${saveDir}/train/ \
  --id_save_filename ${saveDir}/id.txt \
  --is_first_file
