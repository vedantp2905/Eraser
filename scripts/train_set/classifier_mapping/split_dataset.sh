#!/bin/bash

scriptDir=src/classifier_mapping

# Create save directory if it doesn't exist
saveDir='split_dataset'
mkdir -p ${saveDir}

filePath='clusters_csv_train/'

python ${scriptDir}/split_dataset.py \
  --file_path ${filePath} \
  --layer 12 \
  --validation_size 0.1 \
  --train_dataset_save_path ${saveDir}/train/ \
  --validation_dataset_save_path ${saveDir}/validation/ \
  --id_save_filename ${saveDir}/id.txt \
  --is_first_file

