
# Folder locations
dir.local.main <- "D:/Now/library_genetics_epidemiology/"
dir.chapter2 <- paste0(dir.local.main,'slave_NU/NU_data_processed_exports/')

dir.git.input <- "D:/git/PhD_reporting-with-SAS-tables_thesis-supplementary-tables/input_table-data/"


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

