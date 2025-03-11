#!/bin/bash

model=${1}
scriptDir=src/concept_mapper

# Store the project root directory
PROJECT_ROOT=$(pwd)

fileDir=${PROJECT_ROOT}/results/${model}/dev/position_representation_info  #saliency_representation_info #
classifierDir=${PROJECT_ROOT}/results/${model}/train/classifier_mapping/models/model

mkdir "${PROJECT_ROOT}/results/${model}/dev/latent_concepts"
mkdir "${PROJECT_ROOT}/results/${model}/dev/latent_concepts/position_prediction"

layer=12
echo ${layer}
python ${PROJECT_ROOT}/${scriptDir}/logistic_regression.py \
  --test_file_path ${fileDir}/explanation_words_representation_layer${layer}.csv \
  --layer ${layer} \
  --save_path ${PROJECT_ROOT}/results/${model}/dev/latent_concepts/position_prediction/ \
  --do_predict \
  --classifier_file_path ${classifierDir}/layer_${layer}_classifier.pkl \
  --load_classifier_from_local