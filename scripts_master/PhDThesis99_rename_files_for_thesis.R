##########################################################################################
# filename: PhDThesis99_rename_files_for_thesis.R
# Modified from: PRS_UKB_201711_step99_rename_files_for_manuscript-submission.R
# program author: CHIU, Ming-Chung
# purpose: Copy figure, table files from manuscript folders and rename them for PhD thesis
# date created: 20190208
# file directory: 
# note: to rename files, copy them to a new path and then rename them. 
# ref: http://www.r-bloggers.com/operating-on-files-with-r-copy-and-rename/
#-----------------------------------------------------------------------------------------
# CHANGE HISTORY : 
#-----------------------------------------------------------------------------------------
# Sys.time()  Update
#-----------------------------------------------------------------------------------------
# 
#-----------------------------------------------------------------------------------------

# Main local folders
dir.local.main <- "D:/Now/library_genetics_epidemiology/"
dir.thesis.main <- paste0(dir.local.main,"Chang_PhD_thesis/")

dir.thesis.text.docx <- paste0(dir.local.main,"Chang_PhD_thesis/content_docx/")
dir.thesis.references <- paste0(dir.thesis.main,"references/")
dir.thesis.files <- paste0(dir.thesis.main,"chapter-files/")
dir.thesis.supp.tables <- paste0(dir.thesis.files,"supplementary-tables/")
dir.thesis.figures <- paste0(dir.thesis.main,"figures_supplementary-figures/")

# Destination folder (thesis folder)

# Source directory for files to copy to the manuscript folder
#sourceDir_NU <- paste0(dir.local.main,"slave_NU/")
sourceDir_GWAS <- paste0(dir.local.main,"GWAS/")
Google.drive.local <- "D:/googleDrive/GoogleDriveAsMaster/"
#figure_dir <- paste0(sourceDir_GWAS,"plots/")

# Milestone document folders
milestone.1.dir <- paste0(dir.local.main,"Chang2016 QIMR_review_03month/")
milestone.2.dir <- paste0(dir.local.main,"Chang201705_QIMR_review_12month/confirmation_topUp_documents/")
milestone.3.dir <- paste0(dir.local.main,"Chang201805_QIMR_review_24months/")

# Manuscript folders
manu1.dir <- paste0(dir.local.main,"Chang2017_manuscript01/twinResearchAndHumanGenetics/")
manu2.dir <- paste0(dir.local.main,"Chang2018_manuscript02/drug-and-alcohol-dependence/")
manu3.dir <- paste0(Google.drive.local,"Chang_manuscript03_GSCAN-PRSs-predict-legal-substance-use/Drug-and-Alcohol-Dependence/")
manu4.dir <- paste0(Google.drive.local,"Chang_manuscript04_MR-cannabis-licitSubstanceUse/Addiction/")

destination.manu4 <- paste0(Google.drive.local,"Chang_manuscript04_MR-cannabis-licitSubstanceUse/")

manu2_figure_dir <- paste0(figure_dir,"licit_substance_PRSs_predict_illicit_drug_use/")
manu2_tables_dir <- paste0(sourceDir_NU,"NU_analytical_output/NU2_tables_byDate/")
manu2_supTables_dir <- paste0(sourceDir_NU,"NU_analytical_output/NU2_tableSupplementary_byDate/")

manu3_figure_dir <- paste0(figure_dir,"licit_substance_PRSs_predict_licit_substance/")
manu3_tables_dir <- paste0(sourceDir_NU,"NU_analytical_output/NU3_tables_byDate/")
manu3_supTables_dir <- paste0(sourceDir_NU,"NU_analytical_output/NU3_tableSupplementary_byDate/")

manu4_figure_dir <- paste0(figure_dir,"MR_ICC_GSCAN_201806/")
manu4_tables_dir <- paste0(sourceDir_NU,"NU_analytical_output/NU4_tables_byDate/")
manu4_supTables_dir <- paste0(sourceDir_NU,"NU_analytical_output/NU4_tableSupplementary_byDate/")

# Destination where files will be copied and renamed
destination.manu2 <- paste0(dir.local.main,"Chang2018_manuscript02/drug-and-alcohol-dependence/")
destination.manu3 <- paste0(Google.drive.local,"Chang_manuscript03_GSCAN-PRSs-predict-legal-substance-use/addiction/")
destination.manu4 <- paste0(Google.drive.local,"Chang_manuscript04_MR-cannabis-licitSubstanceUse/")

#---------------------------------------------------------------------
# Copy milestone documents to reference folder for writing general inroduction
#---------------------------------------------------------------------
milestone.1.docu.docx.path <- paste0(milestone.1.dir,"Chang2016_3monthReivew05_merged.docx")
milestone.1.docu.PDF.path <- paste0(milestone.1.dir,"Chang2016_3monthReivew05_merged.pdf")

milestone.2.docu.docx.path <- paste0(milestone.2.dir,"Chang201705_12monthReivew01_text.docx")
milestone.2.docu.PDF.path <- paste0(milestone.2.dir,"Chang201705_12monthReivew01_text.pdf")

milestone.3.docu.docx.path <- paste0(milestone.3.dir,"Chang201806_24monthReivew01_mainText.docx")
milestone.3.docu.PDF.path <- paste0(milestone.3.dir,"Chang201806_24monthReivew01_mainText.pdf")

milestone.file.paths <- c( milestone.1.docu.docx.path
                          ,milestone.1.docu.PDF.path
                          ,milestone.2.docu.docx.path
                          ,milestone.2.docu.PDF.path
                          ,milestone.3.docu.docx.path
                          ,milestone.3.docu.PDF.path)

for (i in 1:length(milestone.file.paths)){
  source.file.path <- milestone.file.paths[i]
  source.file.name <- basename(source.file.path)
  destin.file.path <- paste0(dir.thesis.references,source.file.name)
  file.copy(source.file.path,destin.file.path, overwrite = TRUE)
}

#---------------------------------------------------------------------
# Main text file from manuscript 1 for thesis result chapter 1
## Published article in PDF was opened in MS word and saved as same-name.docx in folder D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\references 
#---------------------------------------------------------------------
# Source file path: D:\Now\library_genetics_epidemiology_publishedArticles\Chang et al 2018 The genetic relationship between psychological distress, somatic distress, affective disorders, and substance use in young australian adults A multivariate twin study.pdf

# Destination file path: D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\references\Chang et al 2018 The genetic relationship between psychological distress, somatic distress, affective disorders, and substance use in young australian adults A multivariate twin study.docx

#---------------------------------------------------------------------
# Rename Figure files from manuscript 1 for thesis result chapter 1
#---------------------------------------------------------------------
manu1.fig1.name <- "Figure1_19upDataCollection"
manu1.fig1.path <- paste0(manu1.dir,manu1.fig1.name,".png")
chap1.fig1.path <- paste0(dir.thesis.figures,"chapter01_",manu1.fig1.name,".png")
file.copy(manu1.fig1.path,chap1.fig1.path,overwrite = TRUE)

manu1.fig2.name <- "Figure2_pathDiagram_4variate-P6r-S6r-Adr-Sur_IP_AE_AE_factorLoading_proVariExplained-if-significant"
manu1.fig2.path <- paste0(manu1.dir,manu1.fig2.name,".png")
chap1.fig2.path <- paste0(dir.thesis.figures,"chapter01_",manu1.fig2.name,".png")
file.copy(manu1.fig2.path,chap1.fig2.path,overwrite = TRUE)

#---------------------------------------------------------------------
# Rename table file from manuscript 1 for thesis result chapter 1
#---------------------------------------------------------------------
manu1.table.name <- "NU_tables_2018-04-06_styleGBB.docx"
manu1.table.path <- paste0(manu1.dir,manu1.table.name)
chap1.table.path <- paste0(dir.thesis.text.docx,"PhDThesis02-02_chapter01_tables",".docx")
file.copy(manu1.table.path,chap1.table.path,overwrite = TRUE)

#---------------------------------------------------------------------
# Main text file from manuscript 2 for thesis result chapter 2
## Published article in PDF was opened in MS word and saved as same-name.docx in folder D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\references 
#---------------------------------------------------------------------

# Source file path: D:\Now\library_genetics_epidemiology_publishedArticles\Chang et al 2019 Association between polygenic risk for tobacco or alcohol consumption and liability to licit and illicit substance use in young Australian adults.pdf

# Destination file path: D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\references\Chang et al 2019 Association between polygenic risk for tobacco or alcohol consumption and liability to licit and illicit substance use in young Australian adults.docx

#---------------------------------------------------------------------
# Rename Figure files from manuscript 2 for thesis result chapter 2
#---------------------------------------------------------------------
manu2.fig1.name <- "FIG1"
manu2.fig1.path <- paste0(manu2.dir,manu2.fig1.name,".PNG")
chap2.fig1.path <- paste0(dir.thesis.figures,"chapter02_",manu2.fig1.name,".PNG")
file.copy(manu2.fig1.path,chap2.fig1.path,overwrite = TRUE)

#---------------------------------------------------------------------
# Rename table file from manuscript 2 for thesis result chapter 2
#---------------------------------------------------------------------
manu2.table.name <- "tables_20181225.docx"
manu2.table.path <- paste0(manu2.dir,manu2.table.name)
chap2.table.path <- paste0(dir.thesis.text.docx,"PhDThesis03-02_chapter02_tables",".docx")
file.copy(manu2.table.path,chap2.table.path,overwrite = TRUE)

#---------------------------------------------------------------------
# Rename main text file from manuscript 3 for thesis result chapter 3
## Use the published PDF as source file if publication is done before thesis final submission
#---------------------------------------------------------------------
source.file.path <- paste0(manu3.dir,"manu03_main-text[6]second-revision",".docx")
destin.file.path <- paste0(dir.thesis.references,"manu03_main-text[6]second-revision",".docx")
file.copy(from=source.file.path, to=destin.file.path, overwrite = TRUE)

# Manually copy text of manu03_main-text[6]second-revision.docx to D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\PhD-thesis_05_chapter4_manuscript3.docx

#---------------------------------------------------------------------
# Rename Figure files from manuscript 3 for thesis result chapter 3
#---------------------------------------------------------------------
manu3.fig.name <- "FIG1"
source.file.path <- paste0(manu3.dir,manu3.fig.name,".png")
i <- 1
destin.file.path <- paste0(dir.thesis.figures,"chapter04_manuscript3_figure",i,".png")
file.copy(source.file.path,destin.file.path,overwrite = T)

#---------------------------------------------------------------------
# Rename table file from manuscript 3 for thesis result chapter 3
#---------------------------------------------------------------------
manu3.table.name <- "Tables.docx"
manu3.table.path <- paste0(manu3.dir,manu3.table.name)
chap3.table.path <- paste0(dir.thesis.text.docx,"PhDThesis04-02_chapter03_tables",".docx")
file.copy(manu3.table.path,chap3.table.path,overwrite = TRUE)

#---------------------------------------------------------------------
# Rename main text file from manuscript 4 for thesis result chapter 4
## Use the published PDF as source file if publication is done before thesis final submission
#---------------------------------------------------------------------
source.file.path <- paste0(manu4.dir,"manuscript4-main-text[6]",".docx")
destin.file.path <- paste0(dir.thesis.references,"manuscript4-main-text[6]",".docx")
file.copy(from=source.file.path, to=destin.file.path, overwrite = TRUE)

# Manually copy text of manuscript4-main-text[6].docx to D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\PhD-thesis_05_chapter5_manuscript4.docx

#---------------------------------------------------------------------
# Rename Figure files from manuscript 4 for thesis result chapter 4
#---------------------------------------------------------------------

# To be updated

#---------------------------------------------------------------------
# Rename table file from manuscript 4 for thesis result chapter 4
#---------------------------------------------------------------------
manu4.table.name <- "Tables.docx"
manu4.table.path <- paste0(manu4.dir,manu4.table.name)
chap4.table.path <- paste0(dir.thesis.text.docx,"PhDThesis05-02_chapter04_tables",".docx")
file.copy(manu4.table.path,chap4.table.path,overwrite = TRUE)

#---------------------------------------------------------------------
# Rename Supplementary figure files from manuscripts for thesis result chapters
#---------------------------------------------------------------------

# Get file paths of supplementary figures from manuscript 1
manu1.figS1.name <- "Figure_S1_histogram_PSYCH6_PSYCH6-IRT_SOMA6_SOMA-IRT_by-studyWave"
manu1.figS1.path <- paste0(manu1.dir,manu1.figS1.name,".png")

manu1.figS2.name <- "Figure_S2_IRSF_PSYCH6"
manu1.figS2.path <- paste0(manu1.dir,manu1.figS2.name,".tiff")

manu1.figS3.name <- "Figure_S3_IRSF_SOMA6"
manu1.figS3.path <- paste0(manu1.dir,manu1.figS3.name,".tiff")

manu1.figS4.name <- "Figure_S4_IRSF_affectDisorders"
manu1.figS4.path <- paste0(manu1.dir,manu1.figS4.name,".tiff")

manu1.figS5.name <- "Figure_S5_IRSF_substanceUse"
manu1.figS5.path <- paste0(manu1.dir,manu1.figS5.name,".tiff")

manu1.figS6.name <- "Figure_S6_pathDiagram_4variateM1-M4_choleskyACE_pathCoefficients"
manu1.figS6.path <- paste0(manu1.dir,manu1.figS6.name,".png")

manu1.figS7.name <- "Figure_S7_pathDiagram_4variateM1-M4_independent-pathway-modelACE_pathCoefficients"
manu1.figS7.path <- paste0(manu1.dir,manu1.figS7.name,".png")

manu1.figS8.name <- "Figure_S8_pathDiagram_4variateM1-M4_common-pathway-modelACE_pathCoefficients"
manu1.figS8.path <- paste0(manu1.dir,manu1.figS8.name,".png")

# Get file paths of supplementary figures from manuscript 2
manu2.figS1.name <- "FigS1"
manu2.figS1.path <- paste0(manu2.dir,manu2.figS1.name,".PNG")  

manu2.figS2.name <- "FigS2"
manu2.figS2.path <- paste0(manu2.dir,manu2.figS2.name,".PNG")  

manu2.figS3.name <- "FigS3"
manu2.figS3.path <- paste0(manu2.dir,manu2.figS3.name,".PNG")  

# Get file paths of supplementary figures from manuscript 3
manu3.figS1.name <- "FIG-S1"
manu3.figS1.path <- paste0(manu3_figure_dir,manu3.figS1.name,".png")  

manu3.figS2.name <- "FIG-S2"
manu3.figS2.path <- paste0(manu3_figure_dir,manu3.figS2.name,".png")  

manu3.figS3.name <- "FIG-S3"
manu3.figS3.path <- paste0(manu3_figure_dir,manu3.figS3.name,".png")  

# Rename, copy supplementary figure files to thesis folder
source.figSup.path <- data.frame(
  manuscript_num= c( rep(1,times=8)
                    ,rep(2,times=3)
                    ,rep(3,times=3))
  ,source.file.path= c( manu1.figS1.path
                        ,manu1.figS2.path
                        ,manu1.figS3.path
                        ,manu1.figS4.path
                        ,manu1.figS5.path
                        ,manu1.figS6.path
                        ,manu1.figS7.path
                        ,manu1.figS8.path
                        ,manu2.figS1.path
                        ,manu2.figS2.path
                        ,manu2.figS3.path
                        ,manu3.figS1.path
                        ,manu3.figS2.path
                        ,manu3.figS3.path )
  ,stringsAsFactors = F)

for (i in 1:nrow(source.figSup.path)){
  
  # Get manuscript number
  source.manu.num <- source.figSup.path[i,1]
  # Get source file path
  source.file.path <- source.figSup.path[i,2]
  # Get source file name
  source.file.name <- basename(source.file.path)
  # Get file extension
  source.file.exte <- strsplit(basename(source.file.path),"\\.")[[1]][2]
  
  # Create destination file path
  destin.file.path <- paste0(dir.thesis.figures
                             ,"supplementary-document_"
                             ,"chapter",stringr::str_pad(source.manu.num, width=2,side="left",pad="0")
                             ,"_",source.file.name)
  
  # Copy source file to destination file
  file.copy(source.file.path,destin.file.path, overwrite = TRUE)
}

# supplementary figures for Chapter 6 Discussion
folder.path.SPHERE12 <- "D:/Now/library_genetics_epidemiology/GWAS/sphere/"
source.path.figS6.1 <- paste0(folder.path.SPHERE12,"manhattan_PSYCH6_IRT_20170711",".png")
source.path.figS6.2 <- paste0(folder.path.SPHERE12,"manhattan_SOMA6_IRT_20170711",".png")
source.path.figS6.3 <- paste0(folder.path.SPHERE12,"manhattan_SPHERE12_IRT_20170711",".png")

destin.path.figS6.1 <- paste0(dir.thesis.figures,"manhattan_PSYCH6_IRT_20170711",".png")
destin.path.figS6.2 <- paste0(dir.thesis.figures,"manhattan_SOMA6_IRT_20170711",".png")
destin.path.figS6.3 <- paste0(dir.thesis.figures,"manhattan_SPHERE12_IRT_20170711",".png")

file.copy( from=c(source.path.figS6.1,source.path.figS6.2,source.path.figS6.3)
          ,to=c(destin.path.figS6.1,destin.path.figS6.2,destin.path.figS6.3)
          ,overwrite = TRUE)

#-------------------------------------------------------------------------------------
# Rename supplementary table files from manuscripts for thesis supplementary tables
#-------------------------------------------------------------------------------------
# Manually saved PhD-thesis_supplementary-tables_2020-03-24.rtf as PhD-thesis_supplementary-tables_2020-03-24.docx
source.sup.table.name <- "PhD-thesis_supplementary-tables_2020-03-24.docx"
source.sup.table.path <- paste0(dir.thesis.supp.tables,source.sup.table.name)

destin.sup.table.path <- paste0(dir.thesis.files,"PhD-thesis_10_supplementary-tables.docx") 
file.copy(source.sup.table.path, destin.sup.table.path,overwrite = TRUE)

# Manually save PhD-thesis_10_supplementary-tables.docx as PhD-thesis_10_supplementary-tables.pdf

#-------------------------------------------------------------------------------------
# Thesis files submitted on 20191012
#-------------------------------------------------------------------------------------
# Main text file in docx: D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\PhD-thesis_copy-part-01-to-09.docx

# Two files submitted to UQ system: (1) D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\s4420405_PhD_abstract.pdf (2) D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\s4420405_PhD_thesis.pdf

#-------------------------------------------------------------------------------------
# Thesis files revised after confidential review on 20191012
#-------------------------------------------------------------------------------------
# Main text file in docx: D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\PhD-thesis_copy-part-01-to-09_post-review-revised.docx

# Response to reviewer comments: https://drive.google.com/open?id=1mBzOEQ_sGuIjj6rl3mNQD1dCZJ5U7yT_afl_yaLdfJg

#-------------------------------------------------------------------------------------
# Thesis files used for final submission after examination on 202003 under this folder
## D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\corrected-thesis-submission
#-------------------------------------------------------------------------------------
# Save main text file from docx to PDF: PhD-thesis_copy-part-01-to-09_post-review-revised.pdf

# Read the guideline at https://my.uq.edu.au/files/2070/Guide_eSpace_Corrections.pdf

# Merge these files under D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\chapter-files\
## (1) main text   PhD-thesis_copy-part-01-to-09_post-review-revised.pdf
## (2) supp tables PhD-thesis_10_supplementary-tables.pdf
### to a single PDF: D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\corrected-thesis-submission\s4420405_phd_correctedthesis.pdf

# Rename correction file from
# D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\outcome-of-thesis-examination\reviewers-comments-response[4]corrections-submitted.docx
# to D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\corrected-thesis-submission\s4420405_phd_corrections.pdf

#-----------------------------------------------------------------------------------------#
#------------------------This is the end of this file-------------------------------------#
#-----------------------------------------------------------------------------------------#