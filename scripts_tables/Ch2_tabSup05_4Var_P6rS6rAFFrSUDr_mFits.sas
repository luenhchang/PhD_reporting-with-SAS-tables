/*====================================================================
Program Name  		:	Ch2_tabSup05_4Var_P6rS6rAFFrSUDr_mFits
Modified from			:	NUtabSup05_4Var_P6rS6rAFFrSUDr_mFits.sas 
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190724
__________________________________________________________________________*/

/*------------------------------------------import data into SAS-----------------------------------------------*/
data output.chapter2_tableSup&table_order. ; 
	set &tData_4Var_mFits.; 
	gap01='';	/*add gap01, gap02 for inserting blank in PROC REPORT*/
	gap02='';
	/*Create a variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;
	sectionHeadingCopy=sectionHeading;
	pCopy=p;
	OBSNO=_N_;
run;

/*----------------------------------------Add titles and footnotes------------------------------------------------*/
proc sort data=	output.chapter2_tableSup&table_order.; by report_3rd_node_breaker; run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter2_suppTableContent&table_order."	;

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
column report_3rd_node_breaker sectionHeading pCopy OBSNO 
			modelNumber base comparison df diffdf minus2LL diffLL AIC p ; 

/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/

define sectionHeading / group order=data noprint;
/*define sectionHeadingCopy/ group order=data noprint;*/
/*%def_group(	cVar=anaGroup,	option=group,	cName=Variable set,	cWide=1 cm);*/
define pCopy / noprint;
DEFINE OBSNO / ORDER NOPRINT;
define report_3rd_node_breaker	/	noprint order;
%def_display(	cVar=modelNumber,	cName=Model, 			cWide= 1	cm, 		colAlign=center);
%def_display(	cVar=base,					cName=Base model, 	cWide= 1	cm, 		headerAlign=left, colAlign=left);
%def_display(	cVar=comparison,		cName=Compare, 		cWide= 1	cm, 		headerAlign=left, colAlign=left);
%def_display(	cVar=df,						cName=DF,					cWide= 1 cm, 		colAlign=center);
%def_display(	cVar=diffdf,					cName=diff DF,			cWide= 0.5 cm, 	colAlign=center);
%def_display(	cVar=minus2LL,			cName=-2LL,				cWide= 1.25 cm, 	colAlign=center);
%def_display(	cVar=diffLL,				cName=diff LL,			cWide= 1 cm, 		headerAlign=right, colAlign=d);
%def_display(	cVar=AIC,					cName=AIC,				cWide= 1.25 cm, 	colAlign=center);
%def_display(	cVar=p,						cName=p,					cWide= 1 cm, 		colAlign=d);

/*define all the gap variables*/
*%def_display(	cVar=gap01	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);
*%def_display(	cVar=gap02	,cName=			,isFmt=N	,cFmt=					,cWide=0.2%);

/*conditionally bold rows for the model chosen as the best fitting model (lowest AIC)*/
compute comparison/character;
	if 	base="IP_ACE_AE" and comparison='IP_AE_AE' 
	then call define(_ROW_, "style", 'style=[foreground=black font_weight=bold]' );	
endcomp; 

/*Add blank lines to make double spacing under every report row*/
/*LINE statement here adds a blank row. If text in the quote, a format must be used after the quoted text*/
/*compute after OBSNO ;
    line "";	
endcomp;
*/
compute after _page_ /style={just=l 
							 font_size=10pt 
							 font_face='Times New Roman'  
							 borderbottomcolor=white 
							 bordertopcolor=black};

/*The following footnote has been moved to table title */
/*	line "";
	line "-2LL: twice negative log-likelihood, DF: degrees of freedom, diff DF: difference in degrees of freedom to previous submodel";
	line "diffLL: difference in log-likelihood, AIC: Akaike's information criterion, p: p value";
	line "CI: confidence interval, A: additive genetic factors, C: common environmental factors, E: unique environmental factors" ;
	line	"Bold values indicate best fitting model";
*/ 
endcomp;
/*Remove 3rd node in the Table of contents*/
break before report_3rd_node_breaker/ page contents=""; 
run;

/*----------------------------------------------------This is the end of this program-----------------------------------------------------------------*/
