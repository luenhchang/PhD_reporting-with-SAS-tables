##########################################################################################
# filename: PhDThesis_get-first-sentence-from-title-text.R
# Modified from: D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\scripts\PhDThesis99_rename_files_for_thesis.R
# program author: Chang
# purpose: Get first sentences from supplementary table titles
# date created: 20190725
# file directory: 
# note: 
# ref: 
#-----------------------------------------------------------------------------------------
# Type  FilePath
# Input paste0(dir.scripts,"supp-table_title_text.csv")
# Outpu paste0(dir.scripts,"supp-table_table-of-contents.tsv")
#-----------------------------------------------------------------------------------------
# CHANGE HISTORY : 
#-----------------------------------------------------------------------------------------
# Sys.time()  Update
#-----------------------------------------------------------------------------------------
# 20191007  Exported supp-table_table-of-contents.tsv
# 20190920  Exported supp-table_table-of-contents.tsv
# 20190728  Exported supp-table_table-of-contents.tsv
#-----------------------------------------------------------------------------------------

# Main local folders
localMainDir <- "D:/Now/library_genetics_epidemiology/"
dir.scripts <- paste0(localMainDir,"Chang_PhD_thesis/scripts/")
dir.R.functions <- paste0(localMainDir,"/GWAS/scripts/RFunctions/")

# Import external functions
source(paste0(dir.R.functions,"RFunction_import_export_single_file.R"))

# Import thesis supplementary table title CSV file. Values are in double quotes
ImportACSVValuesInDoubleQuotes(input.file.path = paste0(dir.scripts,"supp-table_title_text.csv")
                               ,data.name = "data") # dim(data) 19 4

# Add new header to the data. Remove prefix "X.." and suffix ".."
pattern.to.search <- glob2rx("X..|..")
colnames(data) <- gsub(colnames(data),pattern = pattern.to.search,replacement = "")

# Create an empty data.frame for appending result in the following loops
base.data <- data.frame()

# Get first sentence from the column text
for (i in 1:nrow(data)){
  study.code <- data[i,"study_code"]
  manuscript.section <- data[i,"manuscript_section"]
  item.order <- data[i,"item_order"]
  text <- data[i,"text"]
  
  # Manipulate string in the text column: (1) Delete unwanted string in the first sentence ^{style [fontweight=bold]. Note double backslashes \\ are escape characters for special characters like ^, { , =, [, ],and }, (2) replace R^{unicode 00B2} with "R-squred" as unicodes cause errors in SAS table of contents,(3) remove }
  s1 <- gsub(text, pattern="\\^\\{style \\[fontweight\\=bold\\]",replacement = "")
  s2 <- gsub(s1,pattern="R\\^\\{unicode 00B2\\}",replacement = "R-squared")
  s3 <- gsub(s2,pattern=".\\} ",replacement = ". ")
  
  # (2) Get the first sentence for table of contents in SAS
  s3.1 <- unlist(stringr::str_split(s3, "[.]"))[1]
  s3.2 <- unlist(stringr::str_split(s3, "[.]"))[2]
  first.sentence <- paste0(s3.1,".",s3.2,".","\"")
  
  # Store result as a temporary data.frame
  temp <- data.frame(study_code= study.code
                     ,manuscript_section= "\"suppTableContent\""
                     ,item_order=item.order
                     ,TOC_text=first.sentence
                     ,stringsAsFactors = F)
  # Append temp to the base data
  base.data <- rbind(base.data,temp)
}

# dim(base.data) 19 4

# Export data as a TSV file in a format similar to the imported file
write.table(base.data
            ,file=paste0(dir.scripts,"supp-table_table-of-contents.tsv")
            ,row.names = F
            ,sep = "\t"
            ,quote=F)

#-----------------------------------------------------------------------------------------#
#------------------------This is the end of this file-------------------------------------#
#-----------------------------------------------------------------------------------------#