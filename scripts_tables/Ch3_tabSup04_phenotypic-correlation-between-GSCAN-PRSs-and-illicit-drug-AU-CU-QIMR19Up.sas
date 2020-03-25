/*====================================================================
Program Name  		:	Ch3_tabSup04_phenotypic-correlation-between-GSCAN-PRSs-and-illicit-drug-AU-CU-QIMR19Up.sas
modifiedfrom			:	NU2tabSup07_fixed-effect-etimates-GSCAN-PRSs-on_illicit-drug-AU-CU-QIMR19Up.sas
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
Program Flow        	: 
Date				Update
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter3_tableSup&table_order.; 
	set &tData_pheoCorr_PRS_targetPheno.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; gap03=''; gap04=''; gap05='';
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter3_suppTableContent&table_order."	;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/
 
/*first node kept and used in table of contents*/
/*Add a title to the table at line 4 location*/
title4 J=L 
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
									background = TRANSPARENT
									cellwidth= 5%}
     ;

/*The COLUMN statement is used to list each report column
The breaking variable report_3rd_node_breaker needs to be the first thing on the COLUMN statement to get rid of the Table 1 node.
*/
column report_3rd_node_breaker target_phenotype p_value_threshold 
			gap01 ("\brdrb\brdrdot\brdrw5\brdrcf1 Females" 	Freq_si_females 	Freq_ai_females 	Freq_cpd_females 	Freq_sc_females 	Freq_dpw_females) 
			gap02 ("\brdrb\brdrdot\brdrw5\brdrcf1 Males" 		Freq_si_males 	Freq_ai_males 	Freq_cpd_males 		Freq_sc_males 		Freq_dpw_males) 
			gap03 ("\brdrb\brdrdot\brdrw5\brdrcf1 F+M" 		Freq_si_allSexes	Freq_ai_allSexes	Freq_cpd_allSexes	Freq_sc_allSexes	Freq_dpw_allSexes)
				; 
			/*Condition variables on the left of COMPUTE variables that you want to conditionally format based on the conditional variables */
 
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;

*DEFINE OBSNO / ORDER NOPRINT;
%def_group(	cVar=target_phenotype,	option=group, cName=Target phenotype,	 cWide=3 cm, headerAlign=left,colAlign=left);
%def_display( cVar=p_value_threshold, cName=PT,cWide=1.25 cm,	headerAlign=right);
/*set conditional variables to noprint*/

%def_display(	cVar=Freq_si_females,		cName=SI,		cWide=1 cm,	headerAlign=right);  
%def_display(	cVar=Freq_ai_females,		cName=AI,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_cpd_females,		cName=CPD,	cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_sc_females,		cName=SC,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_dpw_females,	cName=DPW,	cWide=1 cm,	headerAlign=right);

%def_display(	cVar=Freq_si_males,		cName=SI,		cWide=1 cm,	headerAlign=right);  
%def_display(	cVar=Freq_ai_males,		cName=AI,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_cpd_males,	cName=CPD,	cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_sc_males,		cName=SC,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_dpw_males,	cName=DPW,	cWide=1 cm,	headerAlign=right);

%def_display(	cVar=Freq_si_allSexes,		cName=SI,		cWide=1 cm,	headerAlign=right);  
%def_display(	cVar=Freq_ai_allSexes,		cName=AI,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_cpd_allSexes,	cName=CPD,	cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_sc_allSexes,		cName=SC,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=Freq_dpw_allSexes,	cName=DPW,	cWide=1 cm,	headerAlign=right);
 
/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=1%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=1%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=1%);
*%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=1%);
*%def_display(	cVar=gap05	,cName=		,isFmt=N	,cFmt=	,cWide=1%); 

/*Insert a blank line under every trait. Activate this line only when double-space is needed*/
compute after target_phenotype; 
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
