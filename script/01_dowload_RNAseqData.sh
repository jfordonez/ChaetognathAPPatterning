#!/bin/bash

# This downloads one SRA run and split into paired FASTQ files.
# Usage: ./01_download_sra.sh SRRXXXXX
# For example we use one of Marletaz et al. (2019) data set, we use it like this:
# /01_download_sra.sh SRR8149062

module load sratoolkit/3.2.0

SRA_ID=$1

if [ -z "${SRA_ID}" ]; then
  echo "Usage: $0 SRR_ID"
  exit 1
fi

fastq-dump \
  --defline-seq '@$sn[_$rn]/$ri' \
  --split-files \
  ${SRA_ID}
  

  
