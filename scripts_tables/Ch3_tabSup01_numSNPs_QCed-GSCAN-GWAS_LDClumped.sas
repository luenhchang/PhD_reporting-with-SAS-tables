/*====================================================================
Program Name  		:	Ch3_tabSup01_numSNPs_QCed-GSCAN-GWAS_LDClumped.sas
modifiedfrom			:	NUtabSup01_1VarBin_t1t2Count.sas
Path                			:	
Program Language	:	SAS V9.4
Purpose					:	create one table 
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190723
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
data output.chapter3_tableSup&table_order.; 
	set &tData_numSNP_QCGSCAN_LDClumped.	;
	/*gap0* variables are for inserting gap between sections*/
	gap01='';	gap02=''; gap03=''; gap04=''; gap05=''; gap06=''; gap07=''; gap08='';  
/*Create a dummy variable to remove third node. This node iscontrolled by the BREAK BEFORE statement*/
	report_3rd_node_breaker=1;  
	OBSNO=_N_;
run;

/*proc contents data=output.chapter3_tableSup&table_order.; run;*/
/*--------------------------------Add titles and footnotes----------------------------------------------------------*/
/*Sorting data by seq_order, which created at step19*/
proc sort data=output.chapter3_tableSup&table_order.; by seq_order; run;

/*Get text for the 1st node of Table of Contents from a SAS macro variable
The first node is controlled with the ODS PROCLABEL statement. 
*/
ODS PROCLABEL="&&chapter3_suppTableContent&table_order."	;
 
/*first node kept and used in table of contents*/
/*Add a title to the table at line 4 location*/
title4 J=L 
		font='Times New Roman' 
		h=10pt 
		"&&chapter3_tableSuppTitle&table_order."  
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
proc report	data=output.chapter3_tableSup&table_order.
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
     ;

/*The COLUMN statement is used to list each report column
The breaking variable report_3rd_node_breaker needs to be the first thing on the COLUMN statement to get rid of the Table 1 node.
*/
column report_3rd_node_breaker trait CHR 
			gap01 	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 5e-08" 	S1QC S1LD )
			gap02	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 1e-05" 	S2QC S2LD)
			gap03	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 1e-03" 	S3QC S3LD)
			gap04	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 1e-02" 	S4QC S4LD)
			gap05	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 5e-02" 	S5QC S5LD)
			gap06	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 0.1" 		S6QC S6LD)
			gap07	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 0.5" 		S7QC S7LD	)
			gap08	("\brdrb\brdrdot\brdrw5\brdrcf1 p < 1" 			S8QC S8LD	) ; /*	gap01 insert a gap between columns with two-level headers 	("\brdrb\brdrdot\brdrw5\brdrcf1 Chromosome" 
		_1 _2 _3 _4 _5 _6 _7 _8 _9 _10 _11 _12 _13 _14 _15 _16 _17 _18 _19 _20 _21 _22 ) gap02 total  TT */
    
/*Each column, in turn, has a DEFINE statement that describes how that column is created and formatted.*/
DEFINE  report_3rd_node_breaker	/	NOPRINT ORDER;
%def_group(	cVar=trait	/*variable name*/
						,option=group			/*specify option=order if to order data alphabeticall; = group if not to order data*/
						,cName=Trait 			/*column header*/
						,isFmt=N				/*apply a format to the variable or not*/	 
						,cFmt=$PRSUKBPhenoAbb.	/*which format*/	
						,cWide=1 cm	);

*DEFINE OBSNO / ORDER NOPRINT;
/*column S1LD, are marked as blue; the other columns are in default foreground black*/
%def_display(	cVar=CHR,	cName=Chromosome,	 cWide=2 cm,	headerAlign=right);

%def_display(	cVar=S1QC,	cName=QC,	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=S1LD,		cName=LD,	 cWide=1 cm,	headerAlign=right, foreground=blue) ;

%def_display(	cVar=S2QC,	cName=QC,	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=S2LD,		cName=LD,	 cWide=1 cm,	headerAlign=right, foreground=blue);

%def_display(	cVar=S3QC,	cName=QC,	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=S3LD,		cName=LD,	 cWide=1 cm,	headerAlign=right, foreground=blue);

%def_display(	cVar=S4QC,	cName=QC,	 cWide=1 cm,	headerAlign=right);
%def_display(	cVar=S4LD,		cName=LD,	 cWide=1 cm,	headerAlign=right, foreground=blue);

%def_display(	cVar=S5QC,	cName=QC,	 cWide=1.5 cm,	headerAlign=right);
%def_display(	cVar=S5LD,		cName=LD,	 cWide=1 cm,		headerAlign=right, foreground=blue);

%def_display(	cVar=S6QC,	cName=QC,	 cWide=1.5 cm,	headerAlign=right);
%def_display(	cVar=S6LD,		cName=LD,	 cWide=1 cm,		headerAlign=right, foreground=blue);

%def_display(	cVar=S7QC,	cName=QC,	 cWide=1.5 cm,	headerAlign=right);
%def_display(	cVar=S7LD,		cName=LD,	 cWide=1 cm,		headerAlign=right, foreground=blue);

%def_display(	cVar=S8QC,	cName=QC,	 cWide=1.75 cm,	headerAlign=right);
%def_display(	cVar=S8LD,		cName=LD,	 cWide=1 cm,		headerAlign=right, foreground=blue);

/*define all the gap variables*/
%def_display(	cVar=gap01	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap02	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap03	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap04	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap05	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap06	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap07	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);
%def_display(	cVar=gap08	,cName=		,isFmt=N	,cFmt=	,cWide=0.2%);

/*insert a blank line under every trait. Activate this line only when double-space is needed*/
compute after trait; 
	line ""; 
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
