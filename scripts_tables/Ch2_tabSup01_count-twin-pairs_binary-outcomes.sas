/*====================================================================
Program Name  		:	Ch2_tabSup01_count-twin-pairs_binary-outcomes.sas
Modified from			:	NUtabSup01_1VarBin_t1t2Count.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190724
NOTE						:  depVar is used insted of depVar. Must ensure "variable" in 
									ROut_NU_allDiagnoses_varNames.xlsx is up-to-date
Reference				:	https://communities.sas.com/t5/ODS-and-Base-Reporting/Remove-Table1-from-Table-of-Contents/td-p/576799
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
____________________________________________________________________________*/

/*---------------------------------------------------------------import data into SAS-------------------------------------------------------*/
data output.chapter2_tableSup&table_order.; /*old table name: out._NU_table_08b3 tem._NU_manuscript01_table01*/
	set &tData_uniVarBin_t1t2Count.	;
	gap01='';	/*add gap01, gap02 for inserting blank in PROC REPORT*/
	gap02='';
	gap03='';
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/
proc sort data=	output.chapter2_tableSup&table_order.; by report_3rd_node_breaker; run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter2_suppTableContent&table_order."	;

/*TITLE and FOOTNOTE
By default, titles and footnotes are both bold and italic. When you change the font, you also turn off the bold and italic features. You can turn them on 
by using the BOLD and ITALIC options. There is no option to turn off boldness and italics, so if you wish to turn them off, use the FONT= option.
*/

/*Add table title using SAS macro variable read from an external CSV file*/ 
title4 J=L 
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
					contents=""  /*Remove default 2nd node from the Table of contents*/
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
column report_3rd_node_breaker varGroup OBSNO depVar  

	gap01 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 MZ twin pairs (twin1, twin2)" 
		twinCPair_MZ_0_0 twinCPair_MZ_0_1 twinCPair_MZ_1_0 twinCPair_MZ_1_1 	)

	gap02 /*insert a gap between columns with two-level headers*/ 
	("\brdrb\brdrdot\brdrw5\brdrcf1 DZ twin pairs (twin1, twin2)" 
		twinCPair_DZ_0_0 twinCPair_DZ_0_1 twinCPair_DZ_1_0 twinCPair_DZ_1_1 		)	

	gap03
	sum_completePairs	N_twinNonMissDepVar; 
    
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
%def_group(	cVar=varGroup	/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Scale /*column header*/
						,cWide=2 cm	
						,headerAlign=left		/*alignment of header text in a column: left, center, right*/
						,colAlign=left 			/*alignment of content in a column: left, center, right, d (decimal point) */
						);

DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
DEFINE OBSNO / ORDER NOPRINT;

%def_display(	cVar=depVar,							cName=Diagnosis,	 cWide=3.5 cm, headerAlign=left, colAlign=left);
%def_display(	cVar=twinCPair_MZ_0_0,	cName=(0, 0),	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=twinCPair_MZ_0_1,	cName=(0, 1),	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=twinCPair_MZ_1_0,	cName=(1, 0),	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=twinCPair_MZ_1_1,	cName=(1, 1),	 cWide=1 cm,	headerAlign=right);

%def_display(	cVar=twinCPair_DZ_0_0,	cName=(0, 0),	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=twinCPair_DZ_0_1,	cName=(0, 1),	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=twinCPair_DZ_1_0,	cName=(1, 0),	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=twinCPair_DZ_1_1,	cName=(1, 1),	 cWide=1 cm,	headerAlign=right);

%def_display(	cVar=sum_completePairs,	cName=Total twin pairs,	 cWide=2.5 cm,	headerAlign=right);	
%def_display(	cVar=N_twinNonMissDepVar,	cName=Total twin individuals,	 cWide=1.5 cm, headerAlign=right);

/*Define all the gap variables*/
%def_display(	cVar=gap01	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
%def_display(	cVar=gap02	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
%def_display(	cVar=gap03	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);

/*Add horitzontal lines under every occurence of dependent variable column*/
compute varGroup;
	if varGroup not="" then call define (_row_
															,'style'
															,'style={bordertopcolor=cyan bordertopwidth=1}');
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
