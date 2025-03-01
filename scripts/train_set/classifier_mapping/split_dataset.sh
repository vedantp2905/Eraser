#!/bin/bash

scriptDir=src/classifier_mapping

# Create save directory if it doesn't exist
saveDir='results/train/classifier_mapping/split_dataset'
mkdir -p ${saveDir}

# Path to the directory containing the CSV file
filePath='results/train/classifier_mapping/'

python ${scriptDir}/split_dataset.py \
  --file_path ${filePath} \
  --layer 12 \
  --validation_size 0.1 \
  --validation_dataset_save_path ${saveDir}/validation/ \
  --train_dataset_save_path ${saveDir}/train/ \
  --id_save_filename ${saveDir}/id.txt \
  --is_first_file
