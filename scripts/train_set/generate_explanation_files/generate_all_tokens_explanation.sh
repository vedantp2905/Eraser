#!/bin/bash

scriptDir=src/generate_explanation_files
clusterPath=eraser_movie/layer12/results
explanation=IG_explanation_files_mass_50/explanation_layer_12.txt
clusterSize=400
percentage=90

savePath=eraser_movie/cluster_Labels_$percentage%
mkdir -p $savePath

layer=12
saveFile=${savePath}/clusterLabel_layer$layer.txt
echo Layer$layer
python ${scriptDir}/generate_all_tokens_explanation.py -i $clusterPath/clusters-$clusterSize.txt -e $explanation -s $saveFile