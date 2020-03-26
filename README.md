# Reporting with SAS tables- An example of creating a RTF file with a table of contents and tables using SAS base programming

### Run the script in the following order

`scripts_master/NU_001_global_setting.sas`

This file brings SAS macros to the global environment

---

`scripts_master/NU_002_create_formats_variableExplanation.sas`

This file creates SAS formats for labeling columns

---

`scripts_master/import_supplementary-table_table-of-contents.sas`

This file imports table title information from `input_table-titles/supp-table_title_text.csv` and stores it as SAS macro variables

---

 `scripts_master/PhDThesis_get-first-sentence-from-title-text.R`

 This file parses `input_table-titles/supp-table_title_text.csv`, substrings the first sentences from individual table titles and export these to `input_table-titles/supp-table_table-of-contents.tsv`

---

 `scripts_master/supp-table-title-text_to_SAS-macro-var.sas`

This file imports `input_table-titles/supp-table_table-of-contents.tsv` and stores information in SAS macro variables

---

`scripts_master/master-file_supplementary-tables.sas`

This master file imports data files from `input_table-data/`, runs individual table script files from `scripts_tables/` and generates a single RTF file under `output/`

---
