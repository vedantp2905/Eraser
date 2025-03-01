#!/bin/bash

model=${1}

# Store the project root directory
PROJECT_ROOT=$(pwd)

# Base directories
fileDir=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/models/validate_predictions
saveDir=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/models/stats
scriptDir=${PROJECT_ROOT}/src/classifier_mapping

mkdir -p ${saveDir}

layer=12
python ${scriptDir}/get_prediction_stats.py \
  --layer ${layer} \
  --file_path ${fileDir} \
  --save_path ${saveDir}/prediction_stats_layer${layer}.txt
