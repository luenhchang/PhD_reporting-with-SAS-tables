/*========================================================================================================
Program Name  		:	NU4tabSup01_observational-association-results.sas
Modifiedfrom			:	NU4tab02_GWAS-sample-size-prevalence_LDSC-SNP-heritability-estimates.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190415
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
	set &tData_observ_assoc. ;	
	gap01='';	gap02=''; /*gap0* variables are for inserting gap between sections*/ 
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter5_suppTableContent&table_order."	;

/*Table title*/
title4 J=L 
		font='Times New Roman' 
		h=10pt
		bold /*bold the title text*/	
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
					 MISSING	 /*Include the missing values. Default is to remove rows with missing values in any column*/
     ;

/*The COLUMN statement is used to list each report column*/
column report_3rd_node_breaker iteration model row_order dup_p_value dep_var predictor 
			gap01 ("\brdrb\brdrdot\brdrw5\brdrcf1Converted Estimates" converted_effect_size_95CI p_value)
			; 
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;

%def_group(	cVar=iteration
						,option=group	
						,cName=Model no. 
						,isFmt=N					
						,cFmt=						
						,cWide=1.5 cm
						,headerAlign=left 
						,colAlign=left	); /*Every value of these two variables was displayed rather than just the first occurrence*/

%def_group(	cVar=model		
						,option=group	
						,cName=Method 
						,isFmt=N				
						,cFmt=					
						,cWide=2.5 cm
						,headerAlign=left 
						,colAlign=left	);

DEFINE row_order/ ORDER NOPRINT	;
/*Set conditional variables to noprint*/
define dup_p_value /noprint;

%def_display(	cVar=dep_var,		cName=Outcome,isFmt=N,cFmt=,cWide=4 cm,	headerAlign= left, colAlign= left); /*cFmt=$var_licit_substance_use_abb.*/
%def_display(	cVar=predictor,	cName=Predictor,isFmt=N,cFmt= ,cWide=4 cm,	headerAlign= left, colAlign= left); 

*%def_display(	cVar=b,	cName=^{unicode beta},			 	cWide=1.5 cm,	headerAlign= right, colAlign= right); 
*%def_display(	cVar=SE,	cName=SE,isFmt=Y,	cFmt=5.3,	cWide=1.5 cm,	headerAlign= right, colAlign= right); 
%def_display(	cVar=p_value,	cName=P value,isFmt=N,	cFmt=,	 cWide=1.5 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=converted_effect_size_95CI,	cName=Effect size (95% CI),isFmt=N,	cFmt=,	 cWide=4 cm,	headerAlign=right, colAlign=right);

/*Define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);

/*Bold rows if p values survive multiple testing 0.01 (0.05/5)
condition variable dup_p_value must be on the left of the COMPUTE block variable predictor 
call define(_col_) applies the format on the compute variable column-wide
call define(_row_) applies the format across entire row*/
compute p_value; /*compute predictor/character;*/
	if dup_p_value.sum < 0.01 and converted_effect_size_95CI not="NC" then	call define(_row_, 'style', 'style=[font_weight=bold]' );
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
