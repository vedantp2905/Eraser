#!/bin/bash

scriptDir=src/concept_mapper
input=filtered
working_file=$input
layer=12

dataPath=results/dev/clustering/layer${layer}
minfreq=5
maxfreq=20
delfreq=1000000

savePath=results/dev/position_representation_info
mkdir $savePath

saveFile=$savePath/explanation_words_representation_layer${layer}.csv
explanation=results/dev/CLS_explanation/explanation_CLS.txt
python ${scriptDir}/match_representation.py --datasetFile $dataPath/dataset/${working_file}_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json --explanationFile $explanation --outputFile $saveFile