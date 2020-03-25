/*====================================================================
Program Name  		:	Ch2_tabSup02_1VarBin_basiAssum_difLL_significance.sas
Modified from			:	NUtabSup02_1VarBin_basiAssum_difLL_significance.sas
Program Language	:	SAS V9.4
Purpose					:	
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190724
NOTE						:  varNameShort is used insted of depVar. Must ensure "varNameShort" in 
									ROut_NU_allDiagnoses_varNames.xlsx is up-to-date
___________________________________________________________________________
Purpose             		:  replace Table S2 that reports difference in minus 2 log likelihood
									with (1) minus 2 log likelihood, (2) diff in degree of freedoms, (3) p value
Run Dependencies 	:  NU_004_tabulate_uniVarSaturatedModellingResults.sas
Date				History
-----------------------------------------------------
20160830	Added fittedModel, againstModel
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter2_tableSup&table_order.;
	set &tData_1varBin_difLL_signiSuper.	;
	rownum=_N_	; /*sorting order of this table*/
	gap01='';	/*add gap01, gap02 for inserting blank in PROC REPORT*/
	gap02='';	
/*Create a variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/ 
	report_3rd_node_breaker=1; 
	OBSNO=_N_;	
run;

/*------------------------------------------------Add titles and footnotes--------------------------------------------------------------------*/
proc sort data=	output.chapter2_tableSup&table_order.; by report_3rd_node_breaker; run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter2_suppTableContent&table_order."	;
 
/*first node kept and used in table of contents*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt  
		"&&chapter2_tableSuppTitle&table_order." 
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
proc report	data=output.chapter2_tableSup&table_order.
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
     ;

/*The COLUMN statement is used to list each report column
The breaking variable report_3rd_node_breaker needs to be the first thing on the COLUMN statement to get rid of the Table 1 node.
*/
column report_3rd_node_breaker varGroup depVar OBSNO 
	gap01 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 Homogeneity of thresholds" H1t H2t H3t H4t) 
	gap02 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 Homogeneity of covariances" H1c H2c H3c H4c)

/*effect of covariate is now estimated from 1Var ACE/ADE model rather than from basic assumption*/
	/*gap03*/ /*insert a gap between columns with two-level headers*/
	/*("\brdrb\brdrdot\brdrw5\brdrcf1 Covariate" age sex	)*/
	; /*base TT statNameShort*/
    
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/

%def_group(	cVar=varGroup	/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Scale /*column header*/
						,cWide=2 cm	
						,headerAlign=left		/*alignment of header text in a column: left, center, right*/
						,colAlign=left 			/*alignment of content in a column: left, center, right, d (decimal point) */
						);

%def_group(	cVar=depVar
						,option=group
						,cName=Diagnosis
						,cWide=3.5 cm
						,headerAlign=left		/*alignment of header text in a column: left, center, right*/
						,colAlign=left 			/*alignment of content in a column: left, center, right, d (decimal point) */
						);

DEFINE OBSNO / ORDER NOPRINT;
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;

%def_display(	cVar=H1t,		cName=H1t,				 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H2t,		cName=H2t,				 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H3t,		cName=H3t,				 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H4t,		cName=H4t,				 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H1c,		cName=H1c,			 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H2c,		cName=H2c,			 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H3c,		cName=H3c,			 cWide=1.5 cm, headerAlign=right, colAlign=d);
%def_display(	cVar=H4c,		cName=H4c,			 cWide=1.5 cm, headerAlign=right, colAlign=d);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
%def_display(	cVar=gap02	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);

/*Add blank lines to make double spacing under every report row*/
/*LINE statement here adds a blank row. If text in the quote, a format must be used after the quoted text*/
compute after varGroup ;
    line "";	
endcomp;

compute after _page_ /style={just=l 
							 font_size=10pt 
							 font_face='Times New Roman'  
							 borderbottomcolor=white 
							 bordertopcolor=black};
	/*line "";
	line "^{super a} indicates p value between 0.001 and 0.01, ^{super b} indicates p value < 0.001"; */
endcomp;

/*Remove 3rd node in the Table of contents*/
break before report_3rd_node_breaker/ page contents=""; 

run;

/*---------------------------------------This is the end of this program----------------------------------------*/
