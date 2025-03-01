#!/bin/bash

model=${1}

# Store the project root directory
PROJECT_ROOT=$(pwd)

scriptDir=src/IG_backpropagation
inputFile=${PROJECT_ROOT}/results/${model}/dev/clustering/movie_dev.txt.tok.sent_len

outDir=${PROJECT_ROOT}/results/${model}/dev/IG_attributions
mkdir -p ${outDir}

layer=12
saveFile=${outDir}/IG_explanation_layer_${layer}.csv
python ${PROJECT_ROOT}/${scriptDir}/ig_for_sequence_classification.py ${inputFile} ${model} $layer ${saveFile}