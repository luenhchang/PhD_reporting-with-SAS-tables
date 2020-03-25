/*====================================================================
Program Name  		:	D:\Now\library_genetics_epidemiology\slave_NU\NU_analytical_programs_tables\NU4tabSup03_proportion-exposure-variance-explained-by-clumped-SNPs 
Modifiedfrom			:	D:\Now\library_genetics_epidemiology\slave_NU\NU_analytical_programs_tables\NU4tabSup06_MR-leave-one-out-analysis_results.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20191024
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
data tem._NU_manuscript04_table&table_order.; 
	set &tData_instrument_strength.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; 
	TT=1; /*insert this variable for breaking pages*/
	OBSNO=_N_;
run;

/*proc contents data=tem._NU_manuscript02_tableSup&table_order.; run;*/
/*--------------------------------Add titles and footnotes----------------------------------------------------------*/
/*Sorting data by seq_order, which created at step19*/
proc sort data=tem._NU_manuscript04_table&table_order.; by OBSNO; run;

/*change a procedure label*/
/*ods proclabel="&tTitle_instrument_strength."	;*/
 
/*first node kept and used in table of contents*/
title4 J=L /*this is the table title*/
		font='Times New Roman' 
		h=10pt 
		bold /*bold the title text*/
		"&&NU4_tableSuppTitle&table_order."  
	;  
/*-----------------------------------------------------------add table body-----------------------------------------------------------*/
/*references								URL
------------------------------------------------------------------------------------------------------------------------------
remove nodes							http://support.sas.com/kb/31/278.html
col header border					http://www.phusewiki.org/docs/2006/CC03.pdf
COMPUTE AFTER _PAGE	http://support.sas.com/rnd/papers/sgf07/sgf2007-report.pdf
----------------------------------------------------------------------------------------------------------------------------*/
proc report	data=tem._NU_manuscript04_table&table_order.
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
					MISSING	 /*Include the missing values. Default is to remove rows with missing values in any column*/
     ;

/*The COLUMN statement is used to list each report column*/
column OBSNO exposure_trait SNP BETA PVALUE A1FREQ R_sqaured_SNP
	;

/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
%def_sort(	cVar=OBSNO,						cName=No.,	sortType=internal,	cWide=1 cm);
%def_display(	cVar=exposure_trait ,		cName=Exposure,	cWide=3.5 cm,		headerAlign=left, colAlign=left);
%def_display(	cVar=SNP,						cName=SNP,						cWide=2 cm,		headerAlign=left, colAlign=left);
%def_display(	cVar=BETA,					cName= ^{unicode beta},			cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=PVALUE,				cName= p value,							cWide=1.25 cm,	headerAlign=right);
%def_display(	cVar=A1FREQ,				cName= A1FREQ,	cWide=3.25 cm,	headerAlign=right);
%def_display(	cVar=R_sqaured_SNP,	cName= R^{unicode 00B2},	cWide=1.5 cm,	headerAlign=right);

/*Define all the gap variables*/
*%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);
*%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.25%);

compute after _page_ /style={just=l 
							 font_size=10pt 
							 font_face='Times New Roman'  
							 borderbottomcolor=white 
							 bordertopcolor=black};
endcomp;

run;

/*------------------------------------------This is the end of this program-------------------------------------------------------*/
