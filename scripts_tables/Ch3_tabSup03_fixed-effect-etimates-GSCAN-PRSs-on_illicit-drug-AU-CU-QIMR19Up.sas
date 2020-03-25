/*====================================================================
Program Name  		:	Ch3_tabSup03_fixed-effect-etimates-GSCAN-PRSs-on_illicit-drug-AU-CU-QIMR19Up.sas
modifiedfrom			:	NU2tabSup05_percent-variance-target-phenotypes-explained-by-GSCAN-PRS_sc_dpw.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190723
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
Date				Update
20190728	Error: Word was unable to read this document. It maybe corrupt.
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter3_tableSup&table_order.;  /*528 observations and 43 variables.*/
	set &tData_fixed_effect_PRS.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; gap03=''; gap04=''; gap05='';
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter3_suppTableContent&table_order."	;
 
/*first node kept and used in table of contents*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt 		 
		"&&chapter3_tableSuppTitle&table_order."  
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
proc report	data=output.chapter3_tableSup&table_order.
					contents=""  /*Remove default 2nd node from the Table of contents*/
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
     ;

/*The COLUMN statement is used to list each report column
	 The breaking variable report_3rd_node_breaker needs to be the first thing on the COLUMN statement to get rid of the Table 1 node.
*/
column report_3rd_node_breaker phenotype name_fixEffect_pThre sex_group
			/*Condition variables on the left of COMPUTE variables that you want to conditionally format based on the conditional variables */
			dup_si_pvalue2sided dup_ai_pvalue2sided	dup_cpd_pvalue2sided		dup_sc_pvalue2sided dup_dpw_pvalue2sided /**/	

			gap01 	("\brdrb\brdrdot\brdrw5\brdrcf1 SI" 		si_fix_eff_esti si_SE si_pvalue2sided si_R2_x100)
			gap02	("\brdrb\brdrdot\brdrw5\brdrcf1 AI" 		ai_fix_eff_esti ai_SE ai_pvalue2sided ai_R2_x100)
			gap03  ("\brdrb\brdrdot\brdrw5\brdrcf1 CPD" 	cpd_fix_eff_esti cpd_SE cpd_pvalue2sided cpd_R2_x100)
			gap04  ("\brdrb\brdrdot\brdrw5\brdrcf1 SC"		sc_fix_eff_esti sc_SE sc_pvalue2sided sc_R2_x100)
			gap05 ("\brdrb\brdrdot\brdrw5\brdrcf1 DPW"	dpw_fix_eff_esti dpw_SE dpw_pvalue2sided dpw_R2_x100)
			; /*	gap01 insert a gap between columns with two-level headers */
   
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
*DEFINE OBSNO / ORDER NOPRINT;
/*column S1LD, are marked as blue; the other columns are in default foreground black*/
%def_group(	cVar=phenotype,	option=group, cName=Target phenotype,	 cWide=2 cm, colAlign=left);
%def_group( cVar=name_fixEffect_pThre, cName=PT, isFmt=N, cWide=0.5 cm,	headerAlign=right);
%def_display( cVar=sex_group, cName=Sex, isFmt=Y, cFmt=$sexGroups3_. ,cWide=1 cm,	headerAlign=right);

/*set conditional variables to noprint*/
define dup_si_pvalue2sided	/noprint;
define dup_dpw_pvalue2sided	/noprint;
define dup_ai_pvalue2sided	/noprint;
define dup_cpd_pvalue2sided	/noprint;
define dup_sc_pvalue2sided	/noprint;

%def_display(	cVar=si_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=si_SE,						cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=si_pvalue2sided,	cName=p,	cWide=1.1 cm,	headerAlign=right);
%def_display(	cVar=si_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=ai_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=ai_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=ai_pvalue2sided,	cName=p,	cWide=1.1 cm,	headerAlign=right);
%def_display(	cVar=ai_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=cpd_fix_eff_esti,	cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=cpd_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=cpd_pvalue2sided,	cName=p,	cWide=1.1 cm,	headerAlign=right);
%def_display(	cVar=cpd_R2_x100,		cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=sc_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=sc_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=sc_pvalue2sided,	cName=p,	cWide=1.1 cm,	headerAlign=right);
%def_display(	cVar=sc_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=dpw_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=dpw_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=dpw_pvalue2sided,	cName=p,	cWide=1.1 cm,	headerAlign=right);
%def_display(	cVar=dpw_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap05	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);

/*bold-face estimates if p-value is lower than &corrected_p_threshold.*/

%macro conditionally_format_columns;
	%let variables_to_format=%STR(	si_fix_eff_esti si_SE si_pvalue2sided si_R2_x100
															ai_fix_eff_esti ai_SE ai_pvalue2sided ai_R2_x100
															cpd_fix_eff_esti cpd_SE cpd_pvalue2sided cpd_R2_x100
															sc_fix_eff_esti sc_SE sc_pvalue2sided sc_R2_x100
															dpw_fix_eff_esti dpw_SE dpw_pvalue2sided dpw_R2_x100)	; /*4*5 columns to process*/
	/*4*2 condition variables at which the 20 variables above are computed agicolumns to process*/
	%let condition_variables= %STR(dup_si_pvalue2sided 		dup_si_pvalue2sided 		dup_si_pvalue2sided 		dup_si_pvalue2sided
															dup_ai_pvalue2sided		dup_ai_pvalue2sided		dup_ai_pvalue2sided		dup_ai_pvalue2sided
															dup_cpd_pvalue2sided	dup_cpd_pvalue2sided	dup_cpd_pvalue2sided	dup_cpd_pvalue2sided
															dup_sc_pvalue2sided		dup_sc_pvalue2sided		dup_sc_pvalue2sided		dup_sc_pvalue2sided	
															dup_dpw_pvalue2sided	dup_dpw_pvalue2sided	dup_dpw_pvalue2sided	dup_dpw_pvalue2sided ) ; 

	%let n_var2format=%sysfunc(countw(&variables_to_format.));
	%let corrected_p_threshold=0.0007142857;

	%do i=1 %to &n_var2format.;
        %let var_01 = %scan(&variables_to_format., &i.);
        %let var_02 = %scan(&condition_variables., &i.);
		
        compute &var_01.    ;
            if &var_02..sum < &corrected_p_threshold.  then 
				/*_COL_ is the column that is associated with the COMPUTE block variable*/
				call define(_COL_, 'style', 'style=[foreground=blue font_weight=bold]' ); 
        endcomp;
    %end;

%mend conditionally_format_columns;
%conditionally_format_columns

/*Insert a blank line under every trait. Activate this line only when double-space is needed*/
compute after phenotype; line ""; endcomp; 

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
