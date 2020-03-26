##########################################################################################
# filename: copy_table-data-files_local-to-git-folder.R
# Modified from: 
# program author: Chang
# purpose: Copy supplementary table data files from local folders to a git folder
# date created: 20200326
#-----------------------------------------------------------------------------------------
# CHANGE HISTORY : 
#-----------------------------------------------------------------------------------------
# Sys.time()  Update
#-----------------------------------------------------------------------------------------
# 2020-03-26 Copied files to the git folder
#-----------------------------------------------------------------------------------------

# Folder locations of input 
dir.local.main <- "D:/Now/library_genetics_epidemiology/"
dir.chapter2 <- paste0(dir.local.main,'slave_NU/NU_data_processed_exports/')
dir.chapter3 <- paste0(dir.local.main,'GWAS/PRS_UKB_201711/')
dir.chapter4 <- paste0(dir.local.main,'GWAS/PRS_UKB_201711/')
dir.chapter5 <- paste0(dir.local.main,"GWAS/MR_ICC_GSCAN_201806/")

dir.thesis <- paste0(dir.local.main,"Chang_PhD_thesis/chapter-files/")
dir.supplementary.tables <- paste0(dir.thesis,"supplementary-tables/")

# Folder locations of output
dir.git.main <- "D:/git/PhD_reporting-with-SAS-tables_thesis-supplementary-tables/"
dir.git.input <- paste0(dir.git.main,"input_table-data/")
dir.git.output <- paste0(dir.git.main,"output/") 

#---------------------------------------------------------------------
# Copy supplementary table data files from thesis chapter 2
#---------------------------------------------------------------------
file.s2_1.source <- paste0(dir.chapter2,"manuscript1_count-twin-pairs.tsv")
file.s2_1.destin <- paste0(dir.git.input,basename(file.s2_1.source))

file.s2_2.source <- paste0(dir.chapter2,"manuscript1_univariate-twin-modeling-results_binary-outcomes_model-fits.tsv")
file.s2_2.destin <- paste0(dir.git.input,basename(file.s2_2.source))

file.s2_3.source <- paste0(dir.chapter2,"manuscript1_univariate-twin-modeling-results_continuous-outcomes_model-fits.tsv")
file.s2_3.destin <- paste0(dir.git.input,basename(file.s2_3.source))

file.s2_4.source <- paste0(dir.chapter2,"manuscript1_univariate-ACE-ADE-modeling-results_outcomes-binary-continuous_proportion-variance-explained-by-A-C-E.tsv")
file.s2_4.destin <- paste0(dir.git.input,basename(file.s2_4.source))

file.s2_5.source <- paste0(dir.chapter2,"manuscript1_4var-twin-modelling-results_modelFits.tsv")
file.s2_5.destin <- paste0(dir.git.input,basename(file.s2_5.source))

file.path.s2.source <- c(file.s2_1.source,
                         file.s2_2.source,
                         file.s2_3.source,
                         file.s2_4.source,
                         file.s2_5.source)

file.path.s2.destin <- c(file.s2_1.destin,
                         file.s2_2.destin,
                         file.s2_3.destin,
                         file.s2_4.destin,
                         file.s2_5.destin)

for (i in 1:length(file.path.s2.source)){
  source.file.path <- file.path.s2.source[i]
  destin.file.path <- file.path.s2.destin[i]
  print(paste0("Copying file from ", source.file.path, " to ", destin.file.path))
  file.copy(source.file.path,destin.file.path, overwrite = TRUE)
}

#---------------------------------------------------------------------
# Copy supplementary table data files from thesis chapter 3
#---------------------------------------------------------------------
file.s3_1.source <- paste0(dir.chapter3,'LDBasedClumping/output/','num-SNPs-by-CHR-meet-8-p-thresholds_QCed-GSCAN-GWAS_LD-clumping.csv')
file.s3_1.destin <- paste0(dir.git.input,basename(file.s3_1.source))

file.s3_2.source <- paste0(dir.chapter3,'phenotypeData/','numb-target-pheno-GSCAN-PRS-associ_survived-5-signi-thresholds_manu2-QIMR19Up-everDrug1to9-AUD-CUD_sex-PRS-int-exclu_all-sex-groups.tsv')
file.s3_2.destin <- paste0(dir.git.input,basename(file.s3_2.source))

file.s3_3.source <- paste0(dir.chapter3,"GCTA/output_tabulated/","GCTA_wide-format_fixed-eff_SE_R2_GSCAN-PRS_QIMR-19up_everUsing10drugs-diagAU-diagCU.tsv")
file.s3_3.destin <- paste0(dir.git.input,basename(file.s3_3.source))

file.s3_4.source <- paste0(dir.chapter3,"phenotypic-correlations/","phenotypic-corr-dataframe-between-GSCAN-PRS-and-targ-phenotypes-manu2-QIMR19Up-all-sex-groups.tsv")
file.s3_4.destin <- paste0(dir.git.input,basename(file.s3_4.source))

file.path.s3.source <- c(file.s3_1.source,
                         file.s3_2.source,
                         file.s3_3.source,
                         file.s3_4.source)

file.path.s3.destin <- c(file.s3_1.destin,
                         file.s3_2.destin,
                         file.s3_3.destin,
                         file.s3_4.destin)

for (i in 1:length(file.path.s3.source)){
  source.file.path <- file.path.s3.source[i]
  destin.file.path <- file.path.s3.destin[i]
  print(paste0("Copying file from ", source.file.path, " to ", destin.file.path))
  file.copy(source.file.path,destin.file.path, overwrite = TRUE)
}

#---------------------------------------------------------------------
# Copy supplementary table data files from thesis chapter 4
#---------------------------------------------------------------------
file.s4_1.source <- paste0(dir.chapter4,"phenotypeData/","numb-target-pheno-GSCAN-PRS-associ_survived-5-signi-thresholds_manu3-QIMR-adults-aged20to90_GSCAN-phenotypes_9-diagnoses_sex-PRS-int-inclu.tsv")
file.s4_1.destin <- paste0(dir.git.input,basename(file.s4_1.source))


file.s4_2.source <- paste0(dir.chapter4,"GCTA/output_tabulated/","GCTA_wide-format_fixed-effect-of_PRS_sex-PRS_on_QIMR-adults-aged-20-90_GSCAN-phenotypes_nicotine-alcohol-dependence-and-more_sex-PRS-int-included-in-models.tsv")
file.s4_2.destin <- paste0(dir.git.input,basename(file.s4_2.source))

file.s4_3.source <- paste0(dir.chapter4,"phenotypeData/","numb-target-pheno-GSCAN-PRS-associ_survived-5-signi-thresholds_manu3-QIMR-adults-aged-20-90-GSCAN-phenotypes_nicotine-alcohol-dependence-and-more_sex-PRS-int-exclu_all-sex-groups.tsv") # This file name is too long to copy
file.s4_3.destin <- paste0(dir.git.input,"Ch4_table-Sup03_file-renamed.tsv")

file.s4_4.source <- paste0(dir.chapter4,"GCTA/output_tabulated/","GCTA_wide-format_fixed-eff_SE_R2_GSCAN-PRS_QIMR-adults-aged-20-90_GSCAN-phenotypes_nicotine-alcohol-dependence-and-more.tsv")
file.s4_4.destin <- paste0(dir.git.input,basename(file.s4_4.source))

file.path.s4.source <- c(file.s4_1.source,
                         file.s4_2.source,
                         file.s4_3.source,
                         file.s4_4.source)

file.path.s4.destin <- c(file.s4_1.destin,
                         file.s4_2.destin,
                         file.s4_3.destin,
                         file.s4_4.destin)

for (i in 1:length(file.path.s4.source)){
  source.file.path <- file.path.s4.source[i]
  destin.file.path <- file.path.s4.destin[i]
  print(paste0("Copying file from ", source.file.path, " to ", destin.file.path))
  file.copy(source.file.path,destin.file.path, overwrite = TRUE)
}

#---------------------------------------------------------------------
# Copy supplementary table data files from thesis chapter 5
#---------------------------------------------------------------------
file.s5_1.source <- paste0(dir.chapter5,"LD-score-correlation/output/result-tabulated/","LDSC-SNP-heritability_sample-size-prevalence.tsv")
file.s5_1.destin <- paste0(dir.git.input,basename(file.s5_1.source))   

file.s5_2.source <- paste0(dir.chapter5,"LD-score-correlation/output/result-tabulated/","LDSC-genetic-correlations.tsv")
file.s5_2.destin <- paste0(dir.git.input,basename(file.s5_2.source))   

file.s5_3.source <- paste0(dir.chapter5,"instrument-strength/","proportion-MR-exposure-variance-explained-by-clumped-SNPs.tsv")
file.s5_3.destin <- paste0(dir.git.input,basename(file.s5_3.source))   

file.s5_4.source <- paste0(dir.chapter5,"two-sample-MR/result-tabulated/","heterogeneity-test_two-sample-MR-results_sorted.tsv")
file.s5_4.destin <- paste0(dir.git.input,basename(file.s5_4.source))   

file.s5_5.source <- paste0(dir.chapter5,"MR-PRESSO/result-tabulated/","MR-PRESSO-global-test-results.tsv")
file.s5_5.destin <- paste0(dir.git.input,basename(file.s5_5.source))   

file.s5_6.source <- paste0(dir.chapter5,"MR-PRESSO/result-tabulated/","leave-one-SNP-out-analysis-results_association-GSCAN-smoking-initiation_on_UKB-caffeine-consumed-per-day.tsv")
file.s5_6.destin <- paste0(dir.git.input,basename(file.s5_6.source))   

file.s5_7.source <- paste0(dir.chapter5,"observational-associations/","phenotypic-association-results_outcomes-predictors-matched-MR-outcomes-exposures.tsv")
file.s5_7.destin <- paste0(dir.git.input,basename(file.s5_7.source))   

file.path.s5.source <- c(file.s5_1.source,
                         file.s5_2.source,
                         file.s5_3.source,
                         file.s5_4.source,
                         file.s5_5.source,
                         file.s5_6.source,
                         file.s5_7.source)

file.path.s5.destin <- c(file.s5_1.destin,
                         file.s5_2.destin,
                         file.s5_3.destin,
                         file.s5_4.destin,
                         file.s5_5.destin,
                         file.s5_6.destin,
                         file.s5_7.destin)

for (i in 1:length(file.path.s5.source)){
  source.file.path <- file.path.s5.source[i]
  destin.file.path <- file.path.s5.destin[i]
  print(paste0("Copying file from ", source.file.path, " to ", destin.file.path))
  file.copy(source.file.path,destin.file.path, overwrite = TRUE)
}

#---------------------------------------------------------------------
# Copy supplementary table file RTF from thesis folder to git folder
#---------------------------------------------------------------------
file.subTables.source <- paste0(dir.supplementary.tables,"PhD-thesis_supplementary-tables_2020-03-24.rtf")
file.subTables.destin <- paste0(dir.git.output,basename(file.subTables.source))   
file.copy(file.subTables.source,file.subTables.destin,overwrite = TRUE)

file.subTables.PDF.source <- paste0(dir.thesis,"PhD-thesis_10_supplementary-tables.pdf")
file.subTables.PDF.destin <- paste0(dir.git.output,basename(file.subTables.PDF.source))   
file.copy(file.subTables.PDF.source,file.subTables.PDF.destin,overwrite = TRUE)

#---------------------------- This is the end of this program-------------------------#

