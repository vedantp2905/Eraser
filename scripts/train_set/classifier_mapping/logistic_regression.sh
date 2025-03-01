#!/bin/bash

scriptDir=src/classifier_mapping
fileDir=results/train/classifier_mapping/split_dataset
savePath=results/train/classifier_mapping/models

mkdir -p ${savePath}

layer=12
python ${scriptDir}/logistic_regression.py \
    --train_file_path ${fileDir}/train/train_df_${layer}.csv \
    --validate_file_path ${fileDir}/validation/validation_df_${layer}.csv \
    --layer ${layer} \
    --save_path ${savePath} \
    --do_train \
    --do_validate
