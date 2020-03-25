/*====================================================================
Program Name  		:	Ch2_tabSup03_1VarCon_basiAssum_difLL_significance.sas
Modified from			:	NUtabSup03_1VarCon_basiAssum_difLL_significance.sas
Program Language	:	SAS V9.4
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190724
NOTE						:  varDescription is used insted of depVar. Must ensure "varDescription" in 
									ROut_NU_allDiagnoses_varNames.xlsx is up-to-date
___________________________________________________________________________
Purpose             		: 
Run Dependencies 	:  
Macro Calls   
	External          		: 	
  	Internal          		:	
Files  
  Input             			:	
  Output            		: 	
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter2_tableSup&table_order. ; 
	set &tData_1varCon_difLL_signiSuper.	;
	OBSNO=_N_;
	gap01='';	/*add gap01, gap02 for inserting blank in PROC REPORT*/
	gap02='';
	gap03='';
	gap04='';	
	/*Create a variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
run;

/*------------------------------------------------Add titles and footnotes--------------------------------------------------------------------*/
proc sort data=	output.chapter2_tableSup&table_order.; by OBSNO report_3rd_node_breaker; run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter2_suppTableContent&table_order."	;
 
/*first node kept and used in table of contents*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt 
		"&&chapter2_tableSuppTitle&table_order." /*"&tableSuppTitle3."*/
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
				    style(header)={just=left 
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
column report_3rd_node_breaker varGroup depVar OBSNO  depVar
	gap01 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 Homogeneity of means" H1m H2m H3m H4m)
	gap02 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 Homogeneity of variances" H1v H2v H3v H4v)
	gap03 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 Homogeneity of covariances" H1c H2c H3c H4c)
	/*gap04*/ /*insert a gap between columns with two-level headers*/
	/*("\brdrb\brdrdot\brdrw5\brdrcf1 Covariate" age sex)	*/
		; /*statNameShort varDescription base  TT */
    
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
%def_group(	cVar=varGroup	/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName= Scale /*column header*/
						,cWide=2 cm	
						,headerAlign=left		/*alignment of header text in a column: left, center, right*/
						,colAlign=left 			/*alignment of content in a column: left, center, right, d (decimal point) */
						);

%def_group(	cVar=depVar	/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName= Phenotype /*column header*/
						,cWide=2 cm	
						,headerAlign=left		/*alignment of header text in a column: left, center, right*/
						,colAlign=left 			/*alignment of content in a column: left, center, right, d (decimal point) */
						);

DEFINE OBSNO / ORDER NOPRINT;
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
%def_display(	cVar=H1m,	cName=H1m,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H2m,	cName=H2m,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H3m,	cName=H3m,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H4m,	cName=H4m,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H1v,	cName=H1v,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H2v,	cName=H2v,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H3v,	cName=H3v,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H4v,	cName=H4v,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H1c,	cName=H1c,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H2c,	cName=H2c,	 cWide=1.0 cm, colAlign=d, headerAlign=right);
%def_display(	cVar=H3c,	cName=H3c,	 cWide=1.0 cm, colAlign=d, headerAlign=center);
%def_display(	cVar=H4c,	cName=H4c,	 cWide=1.0 cm, colAlign=d, headerAlign=center);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
%def_display(	cVar=gap02	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
%def_display(	cVar=gap03	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);

/*Add blank lines to make double spacing under every report row*/
/*LINE statement here adds a blank row. If text in the quote, a format must be used after the quoted text*/
compute after OBSNO ;
    line "";	
endcomp;

compute after _page_ /style={just=l 
							 font_size=10pt 
							 font_face='Times New Roman'  
							 borderbottomcolor=white 
							 bordertopcolor=black};
		/*line "";
		line "^{super a} indicates p value between 0.001 and 0.01, ^{super b} indicates p value < 0.001"; */
		/*line "PSYCH6: 6-item psychological symptom subscale of SPHERE-12, SOMA6: 6-item somatic symptom subscale of SPHERE-12
,SUD: substance use disorder";*/
		/*this inserts table footnotes at the last page*/
endcomp;

/*Remove 3rd node in the Table of contents*/
break before report_3rd_node_breaker/ page contents=""; 

run;

/*----------------------------------------------------This is the end of this program-----------------------------------------------------------------*/
