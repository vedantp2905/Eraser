#!/bin/bash

cluster_num=400
baseDir=results/train/clustering
data=movie_train.txt
scriptDir=src/classifier_mapping

minfreq=5
maxfreq=20
delfreq=1000000

saveDir=results/train/classifier_mapping
mkdir -p $saveDir

i=12
datasetFile=${baseDir}/layer$i/dataset/filtered_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json
python ${scriptDir}/generate_csv_file.py \
    --dataset_file $datasetFile \
    --cluster_file ${baseDir}/layer$i/results/clusters-$cluster_num.txt \
    --output_file $saveDir/clusters-map$i.csv

echo "CSV file generated successfully"