/*====================================================================
Program Name  		:	NU4tabSup05_MR-PRESSO_results.sas
Modifiedfrom			:	NU4tabSup04_two-sample-MR-results.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190818
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
	set &tData_MRPRESSO.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; gap03=''; gap04=''; gap05=''; gap06=''; gap07=''; gap08='';  
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1; 
	OBSNO=_N_;
run;

/*proc contents data=tem._NU_manuscript02_tableSup&table_order.; run;*/

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter5_suppTableContent&table_order."	;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/

/*Table title*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt 		
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
     ;

/*The COLUMN statement is used to list each report column
The breaking variable report_3rd_node_breaker needs to be the first thing on the COLUMN statement to get rid of the Table 1 node.
*/
column report_3rd_node_breaker OBSNO 
			("\brdrb\brdrdot\brdrw5\brdrcf1 Exposure GWAS"  exposure_consortium exposure exposure_clumping_p1 ) 
			gap01 ("\brdrb\brdrdot\brdrw5\brdrcf1 Outcome GWAS" outcome_consortium outcome ) 
			gap02 pval_dup  MR_analysis_revised
			gap03 ("\brdrb\brdrdot\brdrw5\brdrcf1 Raw Estimates"  b sd pval)
 			gap04 ("\brdrb\brdrdot\brdrw5\brdrcf1 Converted Estimates" converted_effect_size_95CI) 
			;

/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
define OBSNO/ display noprint; 
%def_display(	cVar=exposure_consortium,	cName=Sample,isFmt=N,cFmt=,cWide=1.25 cm,headerAlign=left,colAlign=left	);
%def_display(	cVar=exposure	, 						cName=Trait,isFmt=N,cFmt=,cWide=3 cm,headerAlign=left,colAlign=left	);
%def_display(	cVar=exposure_clumping_p1,	cName= p1,	isFmt=Y, cFmt=e7.,		cWide=1.5 cm,		headerAlign=left, 	colAlign=left);

%def_display(	cVar=outcome_consortium,		cName= Sample,	isFmt=N, cFmt=,	cWide=1.25 cm,	headerAlign=left, 	colAlign=left);
%def_display(	cVar=outcome,							cName=Trait,	isFmt=N,cFmt=,		cWide=3 cm,		headerAlign=left,		colAlign=left	);
/*Set ordering variables, conditional variables to noprint. Place these variables after the group variables*/
DEFINE pval_dup/display noprint;

%def_display(	cVar=MR_analysis_revised,	cName=Method,isFmt=N,cFmt=,		cWide=3 cm,		headerAlign=left,		colAlign=left	);
%def_display(	cVar=b,									cName= ^{unicode beta},	isFmt=Y, cFmt=7.3,		cWide=1 cm,	headerAlign=left, colAlign=left);
%def_display(	cVar=sd,									cName= SD,		isFmt=Y, cFmt=7.3,		cWide=1 cm,	headerAlign=right);
%def_display(	cVar=pval,								cName= p value,		isFmt=Y, cFmt=e7., cWide=2 cm,	headerAlign=right);

%def_display(	cVar=converted_effect_size_95CI,	cName= Effect size[95%CI],		isFmt=N, cFmt=, cWide=3 cm,	headerAlign=right);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);

/*Conditionally highlight rows with p value < 0.01 (0.05/5)
condition variable pvalueAge must be on the left of the COMPUTE block variable betaEstiAge
call define(_col_) applies the format on the compute variable column-wide
call define(_row_) applies the format across entire row
*/
compute MR_analysis_revised/character ;
	if pval_dup not=. AND pval_dup < 0.01 then do;
		call define(	_row_
						,	'style'
						,	'style=[foreground=blue font_weight=bold]' ) ;
	end;
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
