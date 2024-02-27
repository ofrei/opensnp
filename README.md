# OpenSNP

This repo contains some files and scripts used for processing data from https://opensnp.org/
(see https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3960092/ for the overview of this resource).

Most data files are shared through Zenodo, please download them from 
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10715132.svg)](https://doi.org/10.5281/zenodo.10715132)


Genotype data (``opensnp.zip`` file) is obtained from GenomePrep:
  * https://supfam.mrc-lmb.cam.ac.uk/GenomePrep/downloads.html
  * https://supfam.mrc-lmb.cam.ac.uk/GenomePrep/resource/opensnp.zip

See https://www.csbj.org/article/S2001-0370(21)00278-6/fulltext for additional information about their processing of the genotype data.

Phenotype data is obtained from a full dump (a copy stored on NIRD ``/projects/NS9114K/users/oleksanf/opensnp_2024_02_18/phenotypes_202402180100.csv``):



We extracted and QC'ed standing height from the phenotype data, and manually expected that it has appropriate distribution across subjects, and stratification across genotype-imputed sex.

Then PGS analysis is performed as in opensnp_pgs.ipynb, showing expected association of height PGS with height phenotype.

The folllwing analyses were performed:

  * ``opensnp_qc_geno.ipynb`` - quality control of genotype data, resulting in the following files:
    * ``qc/openSNP.[c1,c3,c4,c5,v4].qc.[bed,bim,fam]`` - QCed genotype, split into 5 batches (c1, c3, c4, c5, v5) based on clusters defined in ``opensnp_genomeslist.tsv`` (see GenomePrep publication for more details), and furhter QCed based on extreme outliers in PCA plots, sample and variant missingness, HWE, sex check, and HET outliers, excluding duplicated (or potentially MZ) samples, or SNPs without any variation
    * ``qc/openSNP.pca.step5.kin0`` - relatedness report
  * ``opensnp_impute.ipynb`` - imputation using 1kG Phase3 data, resulting in:
    * ``imputed/opensnp_hm3.[bed,bim,fam]`` - imputed hard calls for 4257 individuals, 1195793 SNPs (pre-filtered on HapMap3 SNPs)
  * ``opensnp_qc_pheno.ipynb`` - quality control of phenotype data, resulting in:
    * ``qc/pheno.csv`` - phenotype table across subjects, including the following columns:
      * FID IID - subject-level identifies matching genotype & imputed data
      * batch - genotyping batch () 
      * sex - sex imputed from genotype data
      *	ambidextrous, lefthand - binary trait
      *	height_cm - height in centimeters, quantitative trait; after QC this phentoype had appropriate distribution across subjects, and stratification across genotype-imputed sex.
      *	hair_black,	hair_brown,	hair_blonde - heir color, binary trait
      * PC1	PC2	PC3	PC4	PC5	PC6	PC7	PC8	PC9	PC10 - principal components of the genotype data
      * simutrait1	simutrait2 - simulated continuous trait, causal variants across the entire genome
      * simutrait_cc - case/control trait, causal variants across the entire genome
      * simutrait1_chr2122,	simutrait2_chr2122 - continuous trait, causal variants only in chr21 and chr22
      * simutrait_cc_chr2122 - case/control trait, causal variants only in chr21 and chr22
  * ``opensnp_sumstats_qc.ipynb`` - download and QC summary statistics from UK Biobank, resulting in:
      * ``ukb_gwas/UKB_NEALELAB_2018_HAIR_BLACK.GRCh37.hm3.gz``
      * ``ukb_gwas/UKB_NEALELAB_2018_HAIR_DARK_BROWN.GRCh37.hm3.gz``
      * ``ukb_gwas/UKB_NEALELAB_2018_HAIR_BLONDE.GRCh37.hm3.gz``
      * ``ukb_gwas/UKB_NEALELAB_2018_AMBIDEXT.GRCh37.hm3.gz``
      * ``ukb_gwas/UKB_NEALELAB_2018_LEFTHAND.GRCh37.hm3.gz``
      * ``ukb_gwas/UKB_NEALELAB_2018_HEIGHT.GRCh37.hm3.gz``
  * ``opensnp_pgs.ipynb`` - example scripts for polygenic risk scoring analysis, showing expected association of height and hair color PGS with respective phenotypes.
  * ``opensnp_gwas.ipynb`` - example scripts for GWAS analysis

