/*========================================================================================================
Program Name  		:	NU4tabSup03_LDSC-genetic-correlation-results.sas
modifiedfrom			:	NU2tabSup01_count-cases-ctrl_prevalence_chiSqTest.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20180907
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
	set &tData_genetic_correlations. ;	
	gap01='';	gap02=''; gap03=''; /*gap0* variables are for inserting gap between sections*/ 
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
/*first node kept and used in table of contents*/
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
			gap01 	("\brdrb\brdrdot\brdrw5\brdrcf1 Trait 1" trait1_consortium trait1_substance trait1_name)
			gap02 	("\brdrb\brdrdot\brdrw5\brdrcf1 Trait 2" trait2_consortium trait2_substance trait2_name)			 
			gap03	("\brdrb\brdrdot\brdrw5\brdrcf1 Genetic correlations" dup_rG_p_value	rG_esti	rG_SE	rG_Z_score	rG_p_value)			
			; 
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
%def_sort(	cVar=OBSNO,					cName=No.,	sortType=internal,	cWide=0.75 cm);

%def_group(	cVar=trait1_consortium	/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Sample  /*column header*/
						,isFmt=N					/*apply a format to the variable or not*/	 
						,cFmt=						/*which format*/	
						,cWide=1 cm
						,headerAlign=left 
						,colAlign=left	);

%def_display(	cVar=trait1_substance,	cName=Substance,			 	cWide=1.25 cm,	headerAlign= left, colAlign= left); 
%def_display(	cVar=trait1_name,			cName=Trait,isFmt=N,cFmt= ,cWide=4 cm,	headerAlign= left, colAlign= left); 

%def_group(	cVar=trait2_consortium		/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Sample  /*column header*/
						,isFmt=N					/*apply a format to the variable or not*/	 
						,cFmt=						/*which format*/	
						,cWide=1 cm
						,headerAlign=left 
						,colAlign=left	);

%def_display(	cVar=trait2_substance,	cName=Substance,			 			cWide=1.25 cm,	headerAlign= left, colAlign= left); 
%def_display(	cVar=trait2_name,			cName=Trait,	isFmt=N,cFmt= ,	cWide=4.25 cm,	headerAlign= left, colAlign= left); 

/*Set conditional variables to noprint*/
define dup_rG_p_value /noprint;

%def_display(	cVar=rG_esti,			cName=r^{sub G},	isFmt=Y,cFmt=5.3,		cWide=0.75 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=rG_SE,			cName=SE,				isFmt=Y,cFmt=5.3,	 	cWide=0.75 cm,	headerAlign=right, colAlign=right);
%def_display(	cVar=rG_Z_score,	cName=Z score,		isFmt=Y,cFmt=5.3,	 	cWide=1 cm,		headerAlign=right, colAlign=right);
%def_display(	cVar=rG_p_value,	cName=p value,	 	isFmt=Y,cFmt=E7.,		cWide=2 cm,		headerAlign=right, colAlign=right);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);

/*Bold rows if p values survive multiple testing 0.003333333 (0.05/15)
condition variable dup_rG_p_value must be on the left of the COMPUTE block variable rG_esti 
call define(_col_) applies the format on the compute variable column-wide
call define(_row_) applies the format across entire row
Every row is bolded. why?
*/
compute rG_esti;
	if dup_rG_p_value.sum < 0.003333333 then 
		do;
			call define(_row_, 'style', 'style=[foreground=blue font_weight=bold]' );
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
