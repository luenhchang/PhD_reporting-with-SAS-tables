/*========================================================================================================
Program Name  		:	NU4tab02_GWAS-sample-size-prevalence_LDSC-SNP-heritability-estimates.sas
Modifiedfrom			:	NU4tab03_LDSC-genetic-correlation-results_licit-substance-exposure-GSCAN-UKB_outcome-cannabis-initiation-ICC.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190412
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
	set &tData_SNP_heritability. ;	
	gap01='';	gap02=''; /*gap0* variables are for inserting gap between sections*/ 
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

proc sort data=output.chapter5_tableSup&table_order.; by OBSNO; run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter5_suppTableContent&table_order."	;

/*--------------------------------Add titles and footnotes----------------------------------------------------------*/
/*Keep the first node and used in table of contents*/
title4 J=L /*this is the table title*/
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

/*The COLUMN statement is used to list each report column*/
column report_3rd_node_breaker OBSNO consortium substance trait trait_type sample_size sample_prevalence
			gap01 	("\brdrb\brdrdot\brdrw5\brdrcf1 SNP heritability" h2 h2_se lambda_GC mean_chisq intercept intercept_se)
			; 

/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
DEFINE OBSNO/ ORDER NOPRINT	;
%def_group(	cVar=consortium		/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Sample  /*column header*/
						,isFmt=N					/*apply a format to the variable or not*/	 
						,cFmt=						/*which format*/	
						,cWide=1.25 cm
						,headerAlign=left 
						,colAlign=left	);

%def_group(	cVar=substance		/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Substance /*column header*/
						,isFmt=N					/*apply a format to the variable or not*/	 
						,cFmt=						/*which format*/	
						,cWide=1.25 cm
						,headerAlign=left 
						,colAlign=left	);

%def_display(	cVar=trait,		cName=Trait,isFmt=N,cFmt=,cWide=4 cm,	headerAlign= left, colAlign= left); /*cFmt=$var_licit_substance_use_abb.*/
%def_display(	cVar=trait_type,		cName=Type,isFmt=N,cFmt= ,cWide=1.5 cm,	headerAlign= left, colAlign= left); 
%def_display(	cVar=sample_size,	cName=Sample size,isFmt=Y,cFmt=COMMA8. ,	cWide=1.5 cm,	headerAlign= right, colAlign= right); 
%def_display(	cVar=sample_prevalence,	cName=Prevalence,isFmt=Y,	cFmt=$5.,	cWide=1.5 cm,	headerAlign= right, colAlign= right); 
%def_display(	cVar=h2,		cName=^{style[fontstyle=italic]h}^{unicode 00B2},isFmt=Y,	cFmt=5.3,	 cWide=0.75 cm,	headerAlign=right, colAlign=right); 
%def_display(	cVar=h2_se,	cName=SE,isFmt=Y,	cFmt=5.3,	 cWide=0.75 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=lambda_GC,	cName=Lambda GC,isFmt=Y,	cFmt=5.3,	 cWide=1 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=mean_chisq,	cName=Mean Chisq,isFmt=Y,	cFmt=5.3,	 cWide=1 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=intercept,	cName=Intercept,isFmt=Y,	cFmt=5.3,	 cWide=1 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=intercept_se,	cName=Intercept SE,isFmt=Y,	cFmt=5.3,	 cWide=1 cm,	headerAlign=right, colAlign=right);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);

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
