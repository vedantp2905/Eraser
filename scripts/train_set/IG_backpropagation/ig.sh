#!/bin/bash

scriptDir=src/IG_backpropagation
inputFile=results/train/clustering/movie_train.txt.tok.sent_len
model=microsoft/codebert-base # add path to the model to "xxx"

outDir=results/train/IG_attributions
mkdir ${outDir}

layer=12
saveFile=${outDir}/IG_explanation_layer_${layer}.csv
python ${scriptDir}/ig_for_sequence_classification.py ${inputFile} ${model} $layer ${saveFile}