#!/bin/bash

model=${1}
scriptDir=src/concept_mapper

# Store the project root directory
PROJECT_ROOT=$(pwd)

input=filtered
working_file=$input
layer=12

dataPath=${PROJECT_ROOT}/results/${model}/dev/clustering/layer${layer}
minfreq=5
maxfreq=20
delfreq=1000000

savePath=${PROJECT_ROOT}/results/${model}/dev/position_representation_info
mkdir $savePath

saveFile=$savePath/explanation_words_representation_layer${layer}.csv
explanation=${PROJECT_ROOT}/results/${model}/dev/CLS_explanation/explanation_CLS.txt
python ${PROJECT_ROOT}/${scriptDir}/match_representation.py \
    --datasetFile $dataPath/dataset/${working_file}_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json \
    --explanationFile $explanation \
    --outputFile $saveFile