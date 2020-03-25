/*====================================================================
Program Name  		:	Ch2_tabSup04_1VarBinCon_ACE_ADE.sas
Modified from			:	NUtabSup04_1VarBinCon_ACE_ADE.sas
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190724
Run dependency		:	NU_007_tabulate_twinModellingUniVar.sas
Date				Update
__________________________________________________________________________*/

/*------------------------------------------import data into SAS-----------------------------------------------*/
data output.chapter2_tableSup&table_order. ; 
	set &tData_uniVBinCon_ACE_ADE.; /*(where=(&where_condition.))*/
	gap01='';	/*add gap01, gap02 for inserting blank in PROC REPORT*/
	gap02='';
/*Create a variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

/*----------------------------------------Add titles and footnotes------------------------------------------------*/
proc sort data=	output.chapter2_tableSup&table_order.; 
	by report_3rd_node_breaker method varGroup depVar; 
run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter2_suppTableContent&table_order."	;
 
/*first node kept and used in table of contents*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt 
		"&&chapter2_tableSuppTitle&table_order." /*"&tableSuppTitle4." */ 
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
column 
	report_3rd_node_breaker method varGroup depVar OBSNO  comparison2

	gap01 /*insert a gap between columns with two-level headers*/
	("\brdrb\brdrdot\brdrw5\brdrcf1 Goodness-of-fit statistics" 	minus2LL df AIC diffdf  diffLL p)
	
	gap02 /*insert a gap between columns with two-level headers*/
	 ("\brdrb\brdrdot\brdrw5\brdrcf1 Parameter estimates (95% CI) " A A_CI CorD_CI E_CI) ; /*ep  C_CI TT  */

/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/

define method/ noprint;
%def_group(	cVar=varGroup
						,option=group
						,cName=Scale
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
%def_sort(cVar=comparison2, cName=Model, sortType=internal, isFmt=N, cFmt=, cWide=0.8 cm);
%def_display(	cVar=df,					cName=DF,			isFmt=N	,cFmt=, cWide=	1 cm);
%def_display(	cVar=diffdf,				cName=diff DF,	isFmt=N	,cFmt=, cWide=	0.5 cm);
%def_display(	cVar=minus2LL,		cName=-2LL,		isFmt=N	,cFmt=, cWide=	1.25 cm);
%def_display(	cVar=diffLL,			cName=diff LL,	isFmt=N	,cFmt=, cWide=	1 cm);
%def_display(	cVar=AIC,				cName=AIC,		isFmt=N	,cFmt=, cWide=	1.25 cm);
%def_display(	cVar=p,					cName=p,				isFmt=N	,cFmt=, cWide=	1 cm);

define A/ noprint;
%def_display(	cVar=A_CI,				cName=A,			isFmt=N	,cFmt=, cWide=2.25 cm);
*%def_display(	cVar=C_CI,				cName=C,			isFmt=N	,cFmt=, cWide=2.25 cm);
%def_display(	cVar=CorD_CI,		cName=C/D,			isFmt=N	,cFmt=, cWide=2.25 cm);
%def_display(	cVar=E_CI,				cName=E,			isFmt=N	,cFmt=, cWide=2.25 cm);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
%def_display(	cVar=gap02	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);

/*Add blank lines to make double spacing under every report row*/
/*LINE statement here adds a blank row. If text in the quote, a format must be used after the quoted text*/
compute after depVar ; 
	line "";	
endcomp;

compute after _page_ /style={just=l 
							 font_size=10pt 
							 font_face='Times New Roman'  
							 borderbottomcolor=white 
							 bordertopcolor=black};
endcomp;

/*Remove 3rd node in the Table of contents*/
break before report_3rd_node_breaker/ page contents=""; 

run;

/*----------------------------------------------------This is the end of this program-----------------------------------------------------------------*/
