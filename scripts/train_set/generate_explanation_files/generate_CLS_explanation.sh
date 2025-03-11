#!/bin/bash

model=${1}
# Store the project root directory
PROJECT_ROOT=$(pwd)

# Set base directories from project root
scriptDir=${PROJECT_ROOT}/src/generate_explanation_files
inputFile=${PROJECT_ROOT}/results/${model}/train/clustering/movie_train.txt.tok

saveDir=${PROJECT_ROOT}/results/${model}/train/explanations
mkdir -p ${saveDir}

layer=12
python ${scriptDir}/generate_CLS_explanation.py \
    --dataset-name-or-path ${inputFile} \
    --model-name ${model} \
    --tokenizer-name ${model} \
    --save-dir ${saveDir}



