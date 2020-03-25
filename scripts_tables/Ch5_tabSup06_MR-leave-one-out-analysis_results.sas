/*====================================================================
Program Name  		:	D:\Now\library_genetics_epidemiology\slave_NU\NU_analytical_programs_tables\NU4tabSup06_MR-leave-one-out-analysis_results.sas
Modifiedfrom			:	zNU4tab07_MR-leave-one-out-analysis_UKB-CCPD-and-ICC-CI.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190819
NOTE						:  
___________________________________________________________________________
Purpose             		: 
Run Dependencies 	:  
Macro Calls   
	External          		: 	
  	Internal          		:	%conditionalStyle
Files  
  Input             			:	
  Output            		: 	
Program Flow        	: 
Date				Update
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter5_tableSup&table_order.; 
	set &tData_MR_leave_one_out.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; 
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

/*Sorting data by seq_order, which created at step19*/
/*proc sort data=output.chapter5_tableSup&table_order.; by OBSNO; run;*/

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter5_suppTableContent&table_order."	;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/
/*first node kept and used in table of contents*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt 
		bold /*bold the title text*/
		"&&chapter5_tableSuppTitle&table_order."  
	;  
/*Add page number in the footnote section
{thispage} is an internal variable that would automatically count the current page number
Note: Activated table of contents changed pageno= starting-page-number back to 1
*/
FOOTNOTE 	J=center 
						font='Times New Roman' 
						h=10pt
						"Supplementary table page ^{thispage}"
						; 
/*-----------------------------------------------------------Add table body-----------------------------------------------------------*/
/*The 2nd node of table of contents is controlled with the CONTENTS= option on the PROC REPORT statement. Here CONTENTS="" removed the node entirely*/
proc report	data=output.chapter5_tableSup&table_order.
					contents=""  /*remove default 2nd node*/
					nowd 
					split='|'
					style(report)={width=100%  
								   cellpadding=8px
								   font_face='Times New Roman' 
								   font_size=10pt 
								   borderwidth=1.5pt /* border thickness*/ 
								   background = TRANSPARENT}
				    style(header)={just=center 
								   font_weight=bold 
								   font_face='Times New Roman' 
								   font_size=10pt 
								   font_style=roman 
								   protectspecialchars = OFF 
								   background = TRANSPARENT}
					 style(column)={font_face='Times New Roman' 
									font_size=10pt 
									background = TRANSPARENT}
					MISSING	 /*Include the missing values. Default is to remove rows with missing values in any column*/
     ;

/*The COLUMN statement is used to list each report column
The breaking variable report_3rd_node_breaker needs to be the first thing on the COLUMN statement to get rid of the Table 1 node.
*/
column report_3rd_node_breaker OBSNO SNP p_1e5_dup significant_1e5 p_5e8_dup significant_5e8
	gap01
	("\brdrb\brdrdot\brdrw5\brdrcf1 Exposure SNPs clumped at p value < 1e-5"
		("\brdrb\brdrdot\brdrw5\brdrcf1 Raw Estimates"  b_1e5 se_1e5  p_1e5)
		("\brdrb\brdrdot\brdrw5\brdrcf1 Converted Estimates"  converted_effect_size_95CI_1e5)
	)
	gap02
	("\brdrb\brdrdot\brdrw5\brdrcf1 Exposure SNPs clumped at p value < 5e-8"  
		("\brdrb\brdrdot\brdrw5\brdrcf1 Raw Estimates"  b_5e8 se_5e8 p_5e8)
		("\brdrb\brdrdot\brdrw5\brdrcf1 Converted Estimates"  converted_effect_size_95CI_5e8)
	)
	;

/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
%def_sort(	cVar=OBSNO,					cName=No.,	sortType=internal,	cWide=1 cm);
%def_display(	cVar=SNP,					cName=SNP removed,						cWide=2 cm,		headerAlign=left, colAlign=left);
DEFINE p_1e5_dup /ORDER NOPRINT;
DEFINE significant_1e5 /ORDER NOPRINT;
DEFINE p_5e8_dup /ORDER NOPRINT;
DEFINE significant_5e8 /ORDER NOPRINT;
%def_display(	cVar=b_1e5,				cName= ^{unicode beta},			cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=se_1e5,				cName= SE,									cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=p_1e5,				cName= p value,							cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=converted_effect_size_95CI_1e5,				cName= Effecct size [95%CI],	cWide=3.25 cm,	headerAlign=right);

%def_display(	cVar=b_5e8,				cName= ^{unicode beta},			cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=se_5e8,				cName= SE,									cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=p_5e8,				cName= p value,							cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=converted_effect_size_95CI_5e8,				cName= Effecct size [95%CI],	cWide=3.25 cm,	headerAlign=right);

/*Define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);

/*Boldface estimates if p-value is lower than &corrected_p_threshold.*/
%macro conditionally_format_columns;
	%let variables_to_format=%STR(	b_1e5 se_1e5 p_1e5 converted_effect_size_95CI_1e5
															b_5e8 se_5e8 p_5e8 converted_effect_size_95CI_5e8)	; /* 2*4 variables to process*/
	/* Duplicate condition variables so number of variables to format match the number here*/
	%let significance_variables= %STR(	significant_1e5 significant_1e5 significant_1e5 significant_1e5 
																significant_5e8 significant_5e8 significant_5e8 significant_5e8	) ; 
	/*Loop thru each of the 2*4 combinations*/
	%let n_var2format=%sysfunc(countw(&variables_to_format.));
	%do i=1 %to &n_var2format.;
        %let var_compute = %scan(&variables_to_format., &i.);
        %let var_IF = %scan(&significance_variables., &i.);

        compute &var_compute.    ;
            if &var_IF. ="yes"  then 
				/*_COL_ is the column that is associated with the COMPUTE block variable*/
				call define(_COL_, 'style', 'style=[foreground=blue font_weight=bold]' ); 
        endcomp;
    %end;

%mend conditionally_format_columns;
%conditionally_format_columns

compute after _page_ /style={just=l 
							 font_size=10pt 
							 font_face='Times New Roman'  
							 borderbottomcolor=white 
							 bordertopcolor=black};
endcomp;

/*Remove 3rd node in the Table of contents*/
BREAK BEFORE report_3rd_node_breaker/ page contents=""; 

run;

/*------------------------------------------This is the end of this program-------------------------------------------------------*/
