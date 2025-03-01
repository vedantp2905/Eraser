#!/bin/bash

model=${1}
scriptDir=src/generate_explanation_files

# Store the project root directory
PROJECT_ROOT=$(pwd)

inputDir=${PROJECT_ROOT}/results/${model}/dev/IG_attributions
outDir=${PROJECT_ROOT}/results/${model}/dev/IG_explanation_files_mass_50

mkdir -p ${outDir}

layer=12
echo ${inputDir}/IG_explanation_layer_${layer}.csv
saveFile=${outDir}/explanation_layer_${layer}.txt
python ${PROJECT_ROOT}/${scriptDir}/generate_IG_explanation_salient_words.py ${inputDir}/IG_explanation_layer_${layer}.csv ${saveFile} top-k --attribution_mass 0.5