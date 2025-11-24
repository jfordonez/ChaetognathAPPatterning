# ChaetognathAPPatterning
Scripts used to download, assemble, and annotate transcriptomes for Hox gene mining in public SRA datasets. These scripts were used for the paper "Anterior–posterior patterning in the chaetognath Spadella cephaloptera: insights into the evolution of the bilaterian nervous system and postanal tail" submitted to Comms. Bio.

# Hox gene mining pipeline from public transcriptomes

This repository contains example scripts and a minimal walkthrough of the
pipeline used to identify Hox genes from publicly available transcriptomes.

The workflow has four main steps:

1. Download RNA-seq reads from SRA (01_dowload_RNAseqData.sh)
2. Trim and quality-filter reads, then assemble transcriptomes (02_qc_and_assemble.sh)
3. Annotate assembled transcripts by DIAMOND searches against a custom Spiralian Hox database (03.2_annot_diamonBlast.sh)
4. Manually inspect and confirm candidate Hox genes by NCBI BLAST.
  From the DIAMOND results, we:
    4.1. Filter for strong matches (e.g. e-value ≤ 1e-25) to identify candidate Hox transcripts.
    4.2. Extract the corresponding transcript IDs from the assembly FASTA.
    4.3. BLAST these candidates against NCBI (nt/nr) to confirm their identity and assign orthology.
    4.4. This final manual step ensures that only well-supported Hox sequences are retained for downstream phylogenetic analyses.

The scripts are written for a SLURM-based HPC cluster using `module load`, but
can be adapted to other environments.

---

Requirements

- Linux environment
- SLURM (or adjust the `#SBATCH` lines)
- Installed software:
  - [SRA Toolkit](https://github.com/ncbi/sra-tools) (tested with ≥ 3.2.0)
  - [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) (≥ 0.39)
  - [SPAdes](https://cab.spbu.ru/software/spades/) with RNA mode (`spades.py --rna`)
  - [DIAMOND](https://github.com/bbuchfink/diamond) (≥ 2.1.x)
- Adapter fasta for Trimmomatic (e.g. `TruSeq3-PE.fa`)
- A FASTA file containing Spiralian Hox protein sequences to build the custom DIAMOND database

---

