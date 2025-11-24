#!/bin/bash

# Create a diamond database from a fasta file with the amino acid (aa) sequences of your genes of interest. 
# Amino acid sequences can be downloaded from Genbank. Here, the aa fasta file is named as Spiralian_HoxDB.fasta

# Usage: ./03.1_makeHoxDB.sh Spiralian_HoxDB.fasta

module load diamond/2.1.11

DB=$1

diamond makedb \
  --in $1 \
  --db spiralianHox \
  --threads 6
