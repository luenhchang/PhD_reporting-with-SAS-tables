/*====================================================================
Program Path           :	supp-table-title-text_to_SAS-macro-var.sas
Modified from			:	D:\Now\library_genetics_epidemiology\slave_NU\NU_analytical_programs\NU_019_table_titles_footnotes.sas
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190723
Note							:  Close table_title_text.csv when reading it into SAS. Leaving this file open can result in this error: 
									ERROR: Import unsuccessful.  See SAS Log for details.
___________________________________________________________________________
Purpose             		:  Import an Excel file that contains text for table titles, footnotes  
Run Dependencies 	:  manuscriptGlobal.xlsx
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
%let thesis_dir=	D:\Now\library_genetics_epidemiology\Chang_PhD_thesis	;
%let SAS_script_dir= &thesis_dir.\scripts	;
%let destin_script_dir=	&thesis_dir.\SAS-supp-table-scripts	;
%let output_dir= &thesis_dir.\SAS-data-sets ;

/*---------------Assign paths to SAS library------------------------------------------------ */
libname output "&output_dir." ;

/*---------------Run external SAS macro files-------------------------------------------------- */
%include "&proj_dir.\NU_analytical_programs\NU_001_global_setting.sas" ;

/*---------------- Store title text from a CSV file in SAS macro variables------------------------*/

/*Import the CSV file*/
options MPRINT;
%SYSMACDELETE getExcelSheets;
%macro getExcelSheets(outputFileName=);
	proc import 
		out=output.&outputFileName.
		datafile= "&SAS_script_dir.\supp-table_title_text.csv" /*"&metadata_locn.\supp-table_title_text.csv"*/
		DBMS=csv REPLACE		;
		getnames=yes; 
		GUESSINGROWS=19;
	run; 
%mend;

%getExcelSheets(outputFileName=supp_table_titles ); /*20 observations and 4 variables.*/

/*Remove double quotes using newvariable=compress(oldvariable,'"')*/
data output.supp_table_titles_quotes_rm;
	set output.supp_table_titles;
	study_code= compress(__study_code__,'"');
	manuscript_section=compress(__manuscript_section__,'"');
	item_order= compress(__item_order__,'"');
	text= compress(__text__,'"');
	keep study_code manuscript_section item_order text;
run;

/*Create SAS macro variables taking values from the imported CSV file*/
data _NULL_;
	set output.supp_table_titles_quotes_rm;
/*Create an ID for each row of title text. Include no white space*/	
	tableTitleID= CAT(	compress(study_code)
									,"_"
									,compress(manuscript_section)
									,put(item_order,1.0)	);
/*assign Excel text column to macro variables that combines 3 excel columns- STUDY, manuscriptSection, number
*/
	call symput(tableTitleID,text);
run;

/*An example of calling the macro variables above
study_code item_order	MacroVarName										value
-------------------------------------------------------------------------------------------------
NU2				1					&&NU2_tableSuppTitle&table_order. 	table title text for &table_order that resolves to 1  
-------------------------------------------------------------------------------------------------
*/

