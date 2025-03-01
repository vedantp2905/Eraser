#!/bin/bash

scriptDir=../src/clustering
inputPath=../data/ # path to a sentence file
input=movie_train.txt #name of the sentence file

# put model name or path to a finetuned model for "xxx"
model=microsoft/codebert-base

# maximum sentence length
sentence_length=512

# analyze latent concepts of layer 12
layer=12

cd eraser_movie  # Change to cpp_analysis directory where base files are

# Create directories
mkdir -p layer${layer}/results

working_file=$input.tok.sent_len #do not change this

# Extract layer-wise activations
python ${scriptDir}/neurox_extraction.py \
     --model_desc ${model} \
     --input_corpus ${working_file} \
     --output_file layer${layer}/${working_file}.activations.json \
     --output_type json \
     --decompose_layers \
     --include_special_tokens \
     --filter_layers ${layer} \
     --input_type text

# Create a dataset file with word and sentence indexes
python ${scriptDir}/create_data_single_layer.py --text-file ${working_file}.modified --activation-file layer${layer}/${working_file}.activations-layer${layer}.json --output-prefix layer${layer}/${working_file}-layer${layer}

# Filter number of tokens to fit in the memory for clustering
minfreq=5
maxfreq=20
delfreq=1000000
python ${scriptDir}/frequency_filter_data.py --input-file layer${layer}/${working_file}-layer${layer}-dataset.json --frequency-file ${working_file}.words_freq --sentence-file layer${layer}/${working_file}-layer${layer}-sentences.json --minimum-frequency $minfreq --maximum-frequency $maxfreq --delete-frequency ${delfreq} --output-file layer${layer}/${working_file}-layer${layer}

# Run clustering
DATASETPATH=layer${layer}/${working_file}-layer${layer}_min_${minfreq}_max_${maxfreq}_del_${delfreq}-dataset.json
VOCABFILE=layer${layer}/results/processed-vocab.npy  # Changed path
POINTFILE=layer${layer}/results/processed-point.npy  # Changed path
RESULTPATH=layer${layer}/results

CLUSTERS=400,400,400

# Extract data first
python -u ${scriptDir}/extract_data.py --input-file $DATASETPATH --output-path layer${layer}/results  # Changed output path

echo "Creating Clusters!"
python -u ${scriptDir}/get_agglomerative_clusters.py --vocab-file $VOCABFILE --point-file $POINTFILE --output-path $RESULTPATH --cluster $CLUSTERS --range 1
echo "DONE!"

cd ..
echo $PWD
