#!/bin/bash

model=${1}
# Store the project root directory
PROJECT_ROOT=$(pwd)

# Set base directories from project root
scriptDir=${PROJECT_ROOT}/src/IG_backpropagation
inputFile=${PROJECT_ROOT}/results/${model}/train/clustering/movie_train.txt.tok.sent_len

outDir=${PROJECT_ROOT}/results/${model}/train/IG_attributions
mkdir -p ${outDir}

layer=12
saveFile=${outDir}/IG_explanation_layer_${layer}.csv
python ${scriptDir}/ig_for_sequence_classification.py ${inputFile} ${model} $layer ${saveFile}