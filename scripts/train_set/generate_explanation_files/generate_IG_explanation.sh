#!/bin/bash

model=${1}
# Store the project root directory
PROJECT_ROOT=$(pwd)

# Set base directories from project root
scriptDir=${PROJECT_ROOT}/src/generate_explanation_files
inputDir=${PROJECT_ROOT}/results/${model}/train/IG_attributions
outDir=${PROJECT_ROOT}/results/${model}/train/IG_explanation_files_mass_50

mkdir -p ${outDir}

layer=12
echo ${inputDir}/IG_explanation_layer_${layer}.csv
saveFile=${outDir}/explanation_layer_${layer}.txt
python ${scriptDir}/generate_IG_explanation_salient_words.py ${inputDir}/IG_explanation_layer_${layer}.csv ${saveFile} top-k --attribution_mass 0.5