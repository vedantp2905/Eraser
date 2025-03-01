#!/bin/bash

scriptDir=src/generate_explanation_files
model=microsoft/codebert-base
inputFile=results/train/clustering/movie_train.txt.tok

saveDir=results/train/explanations
mkdir -p ${saveDir}

layer=12
python ${scriptDir}/generate_CLS_explanation.py \
    --dataset-name-or-path ${inputFile} \
    --model-name ${model} \
    --tokenizer-name ${model} \
    --save-dir ${saveDir}



