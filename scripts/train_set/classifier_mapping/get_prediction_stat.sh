#!/bin/bash

fileDir=results/train/classifier_mapping/models/validate_predictions/
saveDir=results/train/classifier_mapping/models/stats
scriptDir=src/classifier_mapping

mkdir -p ${saveDir}

layer=12
python ${scriptDir}/get_prediction_stats.py \
  --layer ${layer} \
  --file_path ${fileDir} \
  --save_path ${saveDir}/prediction_stats_layer${layer}.txt
