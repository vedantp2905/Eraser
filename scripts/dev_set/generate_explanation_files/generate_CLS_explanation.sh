#!/bin/bash

scriptDir=src/generate_explanation_files
model=microsoft/codebert-base # add the path to the model to "xxx"
inputFile=results/dev/clustering/movie_dev.txt.tok.sent_len

saveDir=results/dev/CLS_explanation

layer=12
python ${scriptDir}/generate_CLS_explanation.py --dataset-name-or-path ${inputFile} --model-name ${model} --tokenizer-name ${model} --save-dir ${saveDir}



