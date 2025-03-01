#!/bin/bash

scriptDir=src/concept_mapper
input=results/dev/clustering/movie_dev.txt.tok.sent_len
working_file=$input.tok.sent_len

dataPath=results/dev/clustering/layer12/results
minfreq=0
maxfreq=1000000
delfreq=1000000

savePath=position_representation_info
mkdir $savePath

layer=12
saveFile=$savePath/explanation_words_representation_layer${layer}.csv
explanation=results/dev/CLS_explanation/explanation_CLS.txt
python ${scriptDir}/match_representation.py --datasetFile $dataPath/layer$layer/${working_file}-layer${layer}_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json --explanationFile $explanation --outputFile $saveFile