#!/bin/bash
#SBATCH --job-name=rnaspades
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=30G
#SBATCH --output=log/assembly-%j.out
#SBATCH --error=log/assembly-%j.err
#SBATCH --mail-type=end
#SBATCH --mail-user=youremail@institute.edu

module load trimmomatic/0.39
module load spades/3.15.5   # adjust to your SPAdes module name

# Set paths (edit these for your environment)
WORKDIR=/path/to/project/directory
READS=${WORKDIR}/01_rawReads
CLEAN_READS=${WORKDIR}/02_cleanReads
ASSEMBLY=${WORKDIR}/03_Assembly
ADAPTERS=/path/to/TruSeq3-PE.fa

# SRA library to process (without _1/_2 suffix)
LIBRARY_NAME=SRR8149062


# 2.1 Trim reads with Trimmomatic
cd ${READS}

trimmomatic PE -phred33 \
   ${LIBRARY_NAME}_1.fastq ${LIBRARY_NAME}_2.fastq \
   ${CLEAN_READS}/${LIBRARY_NAME}_1_pair.fq ${CLEAN_READS}/${LIBRARY_NAME}_1_unpair.fq \
   ${CLEAN_READS}/${LIBRARY_NAME}_2_pair.fq ${CLEAN_READS}/${LIBRARY_NAME}_2_unpair.fq \
   ILLUMINACLIP:${ADAPTERS}:2:30:10 \
   LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:15 MINLEN:36

# 2.2 Assemble with SPAdes in RNA mode
spades.py \
   -1 ${CLEAN_READS}/${LIBRARY_NAME}_1_pair.fq \
   -2 ${CLEAN_READS}/${LIBRARY_NAME}_2_pair.fq \
   --rna \
   --threads ${SLURM_CPUS_PER_TASK} \
   --memory 30 \
   -o ${ASSEMBLY}/${LIBRARY_NAME}
