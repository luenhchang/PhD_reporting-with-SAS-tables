/*====================================================================
Program Name  		:	Ch4_tabSup02_fixed-effect-etimates-GSCAN-PRSs-on_GSCAN-phenotypes-QIMR-middle-aged-adults_sex-PRS-int-included.sas
Modified from			:	NU3tabSup02-01_fixed-effect-etimates-GSCAN-PRSs-on_GSCAN-phenotypes-QIMR-middle-aged-adults_sex-PRS-int-excluded.sas
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
Program Flow        	: 
Date				Update
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter4_tableSup&table_order.; 
	set &tData_fixed_effect_PRS.;
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
ODS PROCLABEL="&&chapter4_suppTableContent&table_order."	;
 
title4 J=L 
		font='Times New Roman' 
		h=10pt 
		"&&chapter4_tableSuppTitle&table_order."  
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
proc report	data=output.chapter4_tableSup&table_order.
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
column report_3rd_node_breaker phenotype name_fixEffect_pThre name_fix_eff2 /*signi_thres_T4 var_label name_fixEffect_pThre*/
			/*Condition variables on the left of COMPUTE variables that you want to conditionally format based on the conditional variables */
			dup_ai_pvalue2sided	dup_cpd_pvalue2sided	dup_dpw_pvalue2sided	dup_sc_pvalue2sided	dup_si_pvalue2sided

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
%def_group( cVar=name_fixEffect_pThre, cName=PT, isFmt=N, cWide=0.45 cm,	headerAlign=right);
%def_display( cVar=name_fix_eff2, cName=Effect, isFmt=N, cFmt= ,cWide=1.1 cm,	headerAlign=right);

/*set conditional variables to noprint*/
define signi_thres_T4 /noprint;
define dup_ai_pvalue2sided	/noprint;
define dup_cpd_pvalue2sided	/noprint;
define dup_dpw_pvalue2sided	/noprint;
define dup_sc_pvalue2sided	/noprint;
define dup_si_pvalue2sided	/noprint;

%def_display(	cVar=si_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=si_SE,						cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=si_pvalue2sided,	cName=p-value,	cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=si_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=ai_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=ai_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=ai_pvalue2sided,	cName=p-value,	cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=ai_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=cpd_fix_eff_esti,	cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=cpd_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=cpd_pvalue2sided,	cName=p-value,	cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=cpd_R2_x100,		cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=sc_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=sc_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=sc_pvalue2sided,	cName=p-value,	cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=sc_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

%def_display(	cVar=dpw_fix_eff_esti,		cName=Beta,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=dpw_SE,					cName=SE,	 		cWide=0.75 cm,	headerAlign=right);
%def_display(	cVar=dpw_pvalue2sided,	cName=p-value,	cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=dpw_R2_x100,			cName=R^{unicode 00B2},	cWide=0.75 cm,	headerAlign=right);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);
%def_display(	cVar=gap05	,cName=		,isFmt=N	,cFmt=	,cWide=0.1%);

/*bold-face estimates if p-value is lower than signi_thres_T4*/
%macro conditionally_highlight_values;
	%let variables_to_format=%STR(	si_fix_eff_esti 		si_SE 		si_pvalue2sided 		si_R2_x100
															ai_fix_eff_esti 	ai_SE 		ai_pvalue2sided		ai_R2_x100
															cpd_fix_eff_esti 	cpd_SE 	cpd_pvalue2sided 	cpd_R2_x100
															sc_fix_eff_esti 	sc_SE 		sc_pvalue2sided 		sc_R2_x100
															dpw_fix_eff_esti dpw_SE 	dpw_pvalue2sided 	dpw_R2_x100)	; /*20 columns to process*/
	/*20 condition variables at which the 20 variables above are computed againt */
	%let condition_variables= %STR(dup_si_pvalue2sided 		dup_si_pvalue2sided 		dup_si_pvalue2sided 		dup_si_pvalue2sided
															dup_ai_pvalue2sided		dup_ai_pvalue2sided		dup_ai_pvalue2sided		dup_ai_pvalue2sided	
															dup_cpd_pvalue2sided	dup_cpd_pvalue2sided	dup_cpd_pvalue2sided	dup_cpd_pvalue2sided
															dup_sc_pvalue2sided		dup_sc_pvalue2sided		dup_sc_pvalue2sided		dup_sc_pvalue2sided
															dup_dpw_pvalue2sided	dup_dpw_pvalue2sided	dup_dpw_pvalue2sided	dup_dpw_pvalue2sided ) ; 

	%let n_var2format=%sysfunc(countw(&variables_to_format.));
	%let manu3_signi_thres_T4= 0.0007142857 ; /*0.001*/

	%do i=1 %to &n_var2format.;
        %let var_01 = %scan(&variables_to_format., &i.);
        %let var_02 = %scan(&condition_variables., &i.);
		
		/*Here the columns to evaluate, referred by &var_02, are on the right of the COMPUTE block column, referred by &var_01.*/
		compute &var_01.    ;
			if &var_02..sum < &manu3_signi_thres_T4. then
				do;					
					call define(_COL_, 'style', 'style=[foreground=blue font_weight=bold]' ) ; 
				end;
        endcomp;
    %end;

%mend conditionally_highlight_values;
%conditionally_highlight_values

/*Insert a blank line under every trait. Activate this line only when double-space is needed*/
compute after phenotype; 
	line ""; 
endcomp; 

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
