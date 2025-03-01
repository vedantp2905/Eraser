#!/bin/bash

scriptDir=src/clustering
model=microsoft/codebert-base
layer=12

# Base directories
baseDir=results/dev/clustering
inputFile=${baseDir}/movie_dev.txt.tok.sent_len

# Create directories
mkdir -p ${baseDir}/layer${layer}/{activations,dataset,results}

# Extract layer-wise activations
python ${scriptDir}/neurox_extraction.py \
    --model_desc ${model} \
    --input_corpus ${inputFile} \
    --output_file ${baseDir}/layer${layer}/activations/activations.json \
    --output_type json \
    --decompose_layers \
    --include_special_tokens \
    --filter_layers ${layer} \
    --input_type text

# Create dataset file
python ${scriptDir}/create_data_single_layer.py \
    --text-file ${inputFile}.modified \
    --activation-file ${baseDir}/layer${layer}/activations/activations-layer${layer}.json \
    --output-prefix ${baseDir}/layer${layer}/dataset/dataset

# Filter tokens
minfreq=0
maxfreq=100
delfreq=1000000
python ${scriptDir}/frequency_filter_data.py \
    --input-file ${baseDir}/layer${layer}/dataset/dataset-dataset.json \
    --frequency-file ${inputFile}.words_freq \
    --sentence-file ${baseDir}/layer${layer}/dataset/dataset-sentences.json \
    --minimum-frequency ${minfreq} \
    --maximum-frequency ${maxfreq} \
    --delete-frequency ${delfreq} \
    --output-file ${baseDir}/layer${layer}/dataset/filtered

# Run clustering
DATASETPATH=${baseDir}/layer${layer}/dataset/filtered_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json
VOCABFILE=${baseDir}/layer${layer}/results/processed-vocab.npy
POINTFILE=${baseDir}/layer${layer}/results/processed-point.npy
RESULTPATH=${baseDir}/layer${layer}/results
CLUSTERS=400,400,400

# Extract data
python -u ${scriptDir}/extract_data.py \
    --input-file ${DATASETPATH} \
    --output-path ${RESULTPATH}

# Create clusters
python -u ${scriptDir}/get_agglomerative_clusters.py \
    --vocab-file ${VOCABFILE} \
    --point-file ${POINTFILE} \
    --output-path ${RESULTPATH} \
    --cluster ${CLUSTERS} \
    --range 1
