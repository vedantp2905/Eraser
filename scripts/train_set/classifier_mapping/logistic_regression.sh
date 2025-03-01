#!/bin/bash

model=${1}
# Store the project root directory
PROJECT_ROOT=$(pwd)

# Set base directories from project root
scriptDir=${PROJECT_ROOT}/src/classifier_mapping
fileDir=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/split_dataset
savePath=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/models

mkdir -p ${savePath}

layer=12
python ${scriptDir}/logistic_regression.py \
    --train_file_path ${fileDir}/train/train_df_${layer}.csv \
    --validate_file_path ${fileDir}/validation/validation_df_${layer}.csv \
    --layer ${layer} \
    --save_path ${savePath} \
    --do_train \
    --do_validate
