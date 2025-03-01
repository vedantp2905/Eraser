#!/bin/bash

model=${1}
scriptDir=src/generate_explanation_files

# Store the project root directory
PROJECT_ROOT=$(pwd)

clusterPath=${PROJECT_ROOT}/results/${model}/dev/clustering/layer12/results
explanation=${PROJECT_ROOT}/results/${model}/dev/IG_explanation_files_mass_50/explanation_layer_12.txt
clusterSize=400
percentage=90

savePath=${PROJECT_ROOT}/results/${model}/dev/cluster_Labels_$percentage%
mkdir -p $savePath

layer=12
saveFile=${savePath}/clusterLabel_layer$layer.txt
echo Layer$layer
python ${PROJECT_ROOT}/${scriptDir}/generate_all_tokens_explanation.py -i $clusterPath/clusters-$clusterSize.txt -e $explanation -s $saveFile