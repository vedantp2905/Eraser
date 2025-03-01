#!/bin/bash

scriptDir=src/generate_explanation_files
model=microsoft/codebert-base # add the path to the model to "xxx"
inputFile=eraser_movie/movie_train.txt.tok

saveDir=.

layer=12
python ${scriptDir}/generate_CLS_explanation.py --dataset-name-or-path ${inputFile} --model-name ${model} --tokenizer-name ${model} --save-dir ${saveDir}



