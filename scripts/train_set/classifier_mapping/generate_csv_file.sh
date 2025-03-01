#!/bin/bash

model=${1}
cluster_num=400

# Store the project root directory
PROJECT_ROOT=$(pwd)

# Base directories
baseDir=${PROJECT_ROOT}/results/${model}/train/clustering
scriptDir=${PROJECT_ROOT}/src/classifier_mapping

data=movie_train.txt

minfreq=5
maxfreq=20
delfreq=1000000

saveDir=${PROJECT_ROOT}/results/${model}/train/classifier_mapping
mkdir -p $saveDir

i=12
datasetFile=${baseDir}/layer$i/dataset/filtered_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json
python ${scriptDir}/generate_csv_file.py \
    --dataset_file $datasetFile \
    --cluster_file ${baseDir}/layer$i/results/clusters-$cluster_num.txt \
    --output_file $saveDir/clusters-map$i.csv

echo "CSV file generated successfully"