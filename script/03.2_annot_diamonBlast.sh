#!/bin/bash
#SBATCH --job-name=diamond_hox
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --output=log/diamond-%j.out
#SBATCH --error=log/diamond-%j.err
#SBATCH --mail-type=end
#SBATCH --mail-user=youremail@institute.edu

module load diamond/2.1.11

WORKDIR=/path/to/project/directory
ASSEMBLY_ID=SRR8149062
TRANSCRIPTS=${WORKDIR}/03_Assembly/${ASSEMBLY_ID}/transcripts.fasta
OUTNAME=Hox_hits_${ASSEMBLY_ID}

cd ${WORKDIR}/04_HoxBlast

diamond blastx \
  -d spiralianHox \
  -q ${TRANSCRIPTS} \
  -o ${OUTNAME}.out \
  --sensitive \
  --threads ${SLURM_CPUS_PER_TASK} \
  -k 1 \
  -e 1e-10 \
  -b 4.0 \
  -c 1 \
  --max-hsps 1 \
  -f 6
