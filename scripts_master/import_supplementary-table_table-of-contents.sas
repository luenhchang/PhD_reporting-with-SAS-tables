/*====================================================================
Program Path           :	import_supplementary-table_table-of-contents.sas
Modified from			:	supp-table-title-text_to_SAS-macro-var.sas
Program Language	:	SAS V9.4
Purpose					:	Import table of content TSV file created in PhDThesis_get-first-sentence-from-title-text.R
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190723
Note							:  Close table_title_text.csv when reading it into SAS. Leaving this file open can result in this error: 
									ERROR: Import unsuccessful.  See SAS Log for details.
___________________________________________________________________________
Purpose             		:  
Run Dependencies 	:  PhDThesis_get-first-sentence-from-title-text.R
Macro Calls   
	External          		: 	
  	Internal          		:	
Files  
  Input             			:	
  Output            		: 	
Program Flow        	: 
Date				Update
-----------------------------------------------------------------------------------------------------------------------
20180421	Saved the table title as a csv from xlsx to avoid the hassel of 32/64 bit compatibility. Haven't done file saving for
					table footnotes 
20180421 	ERROR: Connect: Class not registered ERROR: Error in the LIBNAME statement. Connection Failed.  See log for details.
					Because Microsoft office is 32bit but SAS is 64bit
20170517	changed macro variable names that reference values in column "text"  the combined values of STUDY,	manuscriptSection, and 
					number column NU_tableTitle1
____________________________________________________________________________*/

/*---------------Set input or output directory-----------------------------------------------------*/
%let proj_dir=		D:\Now\library_genetics_epidemiology\slave_NU	;
%let source_script_dir= &proj_dir.\NU_analytical_programs_tables	;
%let SAS_script_dir= &thesis_dir.\scripts	;
%let output_dir= &thesis_dir.\SAS-data-sets ;

/*---------------Assign paths to SAS library------------------------------------------------ */
libname output "&output_dir." ;

/*---------------Run external SAS macro files-------------------------------------------------- */
%include "&proj_dir.\NU_analytical_programs\NU_001_global_setting.sas" ;

/*---------------- Store title text from a CSV file in SAS macro variables------------------------*/
/*Store folder path in a SAS macro variable*/
%ImportATabSeparatedFile(input_file_path= "&SAS_script_dir.\supp-table_table-of-contents.tsv"
												,numb_rows=20
												,SAS_data_name= output.supp_table_TOC);  /*19 observations and 4 variables.*/

/*Create SAS macro variables taking values from the imported CSV file*/
data _NULL_;
	set output.supp_table_TOC;
/*Create an ID for each row of title text. Include no white space*/	
	supp_table_TOC_ID= CAT(compress(study_code)
												,"_"
												,compress(manuscript_section)
												,put(item_order,1.0)
												);   /*tableTitleID changed to supp_table_TOC_ID*/
/* Assign TOC_text value to SAS macro variables created above*/
	call symput(supp_table_TOC_ID, TOC_text);
run;

/*An example of calling the SAS macro variables created above
study_code	manuscript_section	item_order	SASMacroVarName										value
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
chapter2		suppTableContent	1					&&chapter2_suppTableContent&table_order. 	table title text for &table_order that resolves to 1  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

