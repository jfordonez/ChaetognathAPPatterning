#!/bin/bash

# This downloads one SRA run and split into paired FASTQ files.
# Usage: ./01_download_sra.sh SRRXXXXX
# For example we use one of Marletaz et al. (2019) data set, we use it like this:
# /01_download_sra.sh SRR8149062

module load sratoolkit/3.2.0

DB_NAME=$1

if [ -z "${DB_NAME}" ]; then
  echo "Usage: $0 DB_NAME"
  exit 1
fi

diamond makedb \
  --in $1 \
  --db spiralianHox \
  --threads 6
  

  
