/*====================================================================
Program Name  		:	Ch4_tabSup01_account-for-multiple-testing_associations_GSCAN-PRS_QIMR-middle-aged-adults_GSCAN-phenotypes_9-diagnoses_sexPRS-int-included.sas
modifiedfrom			:	NU3tabSup01-01_account-for-multiple-testing_associations_GSCAN-PRS_QIMR-middle-aged-adults_GSCAN-phenotypes_9-diagnoses.sas
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
data output.chapter4_tableSup&table_order.; 
	set &tData_multiple_testing.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; gap03=''; gap04=''; gap05='';  
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

proc sort data= output.chapter4_tableSup&table_order. ; by order_num; run;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter4_suppTableContent&table_order."	;
 
/*Add a table title at line 4*/
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
column report_3rd_node_breaker phenotype
			gap01 	("\brdrb\brdrdot\brdrw5\brdrcf1 SI" 	count_p_lower_threshold1_si 
																					count_p_lower_threshold2_si 
																					count_p_lower_threshold3_si 
																					count_p_lower_threshold4_si
																					count_p_lower_threshold5_si )
			gap02	("\brdrb\brdrdot\brdrw5\brdrcf1 AI" 	count_p_lower_threshold1_ai
																					count_p_lower_threshold2_ai
																					count_p_lower_threshold3_ai
																					count_p_lower_threshold4_ai
																					count_p_lower_threshold5_ai)
			gap03	("\brdrb\brdrdot\brdrw5\brdrcf1 CPD" 	count_p_lower_threshold1_cpd
																					count_p_lower_threshold2_cpd
																					count_p_lower_threshold3_cpd
																					count_p_lower_threshold4_cpd
																					count_p_lower_threshold5_cpd)
			gap04	("\brdrb\brdrdot\brdrw5\brdrcf1 SC" 	count_p_lower_threshold1_sc
																					count_p_lower_threshold2_sc
																					count_p_lower_threshold3_sc
																					count_p_lower_threshold4_sc
																					count_p_lower_threshold5_sc)
			gap05	("\brdrb\brdrdot\brdrw5\brdrcf1 DPW" 	count_p_lower_threshold1_dpw
																					count_p_lower_threshold2_dpw
																					count_p_lower_threshold3_dpw
																					count_p_lower_threshold4_dpw
																					count_p_lower_threshold5_dpw)
			; 
    
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;

*DEFINE OBSNO / ORDER NOPRINT;
/*column S1LD, are marked as blue; the other columns are in default foreground black*/
%def_group(	cVar=phenotype,	option=group, cName=Target phenotype,	 cWide=3.75 cm,colAlign=left);
*%def_display( cVar=sex_group, cName=Sex, isFmt=Y, cFmt=$sexGroups3_. ,cWide=1 cm,	headerAlign=right);

%def_display(	cVar=count_p_lower_threshold1_si,	cName=T1,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold2_si,	cName=T2,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold3_si ,	cName=T3,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold4_si ,	cName=T4,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold5_si ,	cName=T5,	 cWide=0.60 cm,	headerAlign=right);

%def_display(	cVar=count_p_lower_threshold1_ai,	cName=T1,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold2_ai,	cName=T2,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold3_ai ,	cName=T3,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold4_ai ,	cName=T4,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold5_ai ,	cName=T5,	 cWide=0.60 cm,	headerAlign=right);

%def_display(	cVar=count_p_lower_threshold1_cpd,	cName=T1,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold2_cpd,	cName=T2,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold3_cpd ,	cName=T3,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold4_cpd ,	cName=T4,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold5_cpd ,	cName=T5,	 cWide=0.60 cm,	headerAlign=right);

%def_display(	cVar=count_p_lower_threshold1_sc,	cName=T1,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold2_sc,	cName=T2,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold3_sc ,	cName=T3,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold4_sc ,	cName=T4,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold5_sc ,	cName=T5,	 cWide=0.60 cm,	headerAlign=right);

%def_display(	cVar=count_p_lower_threshold1_dpw,	cName=T1,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold2_dpw,	cName=T2,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold3_dpw ,	cName=T3,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold4_dpw ,	cName=T4,	 cWide=0.60 cm,	headerAlign=right);
%def_display(	cVar=count_p_lower_threshold5_dpw ,	cName=T5,	 cWide=0.60 cm,	headerAlign=right);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap05	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);

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
