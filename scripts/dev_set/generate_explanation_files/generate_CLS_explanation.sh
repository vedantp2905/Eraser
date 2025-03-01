#!/bin/bash

model=${1}
scriptDir=src/generate_explanation_files

# Store the project root directory
PROJECT_ROOT=$(pwd)

inputFile=${PROJECT_ROOT}/results/${model}/dev/clustering/movie_dev.txt.tok.sent_len
saveDir=${PROJECT_ROOT}/results/${model}/dev/CLS_explanation

layer=12
python ${PROJECT_ROOT}/${scriptDir}/generate_CLS_explanation.py --dataset-name-or-path ${inputFile} --model-name ${model} --tokenizer-name ${model} --save-dir ${saveDir}



