#!/bin/bash

model=${1}
# Set base directories from project root
scriptDir=src/clustering
dataDir=data
resultsDir=results/${model}/train/clustering

# Store the project root directory
PROJECT_ROOT=$(pwd)

# Create required directories
mkdir -p ${dataDir}
mkdir -p ${resultsDir}
mkdir -p ${scriptDir}/tokenizer

# Input/output paths
input=movie_train.txt
working_file=$input.tok.sent_len

# Change to results directory
cd ${resultsDir}

# maximum sentence length
sentence_length=512

# 1. Tokenize text with moses tokenizer
perl ${PROJECT_ROOT}/${scriptDir}/tokenizer/tokenizer.perl -l en -no-escape < ${PROJECT_ROOT}/${dataDir}/${input} > $input.tok

# 2. Do sentence length filtering
python ${PROJECT_ROOT}/${scriptDir}/sentence_length.py \
    --text-file $input.tok \
    --length ${sentence_length} \
    --output-file $input.tok.sent_len

# 3. Modify input file
python ${PROJECT_ROOT}/${scriptDir}/modify_input.py \
    --text-file $input.tok.sent_len \
    --output-file $input.tok.sent_len.modified

# 4. Calculate vocabulary size
python ${PROJECT_ROOT}/${scriptDir}/frequency_count.py \
    --input-file ${working_file}.modified \
    --output-file ${working_file}.words_freq

cd ${PROJECT_ROOT}
