/*====================================================================
Program Name  		:	NU_001_global_setting.sas
Program Language	:	SAS V9.4 	
Operating System   	:	Windows 7 professional 64bit
Date created				:	20160512
Global setting			: 	Font=TimeNewRomans, size=16
___________________________________________________________________________
Purpose             		: define libref, global macro variables, execute SAS load programs, run SAS macro
Run Dependencies 	:  
Macro Calls   
	External          		: 	see the list of SAS macro files in the &list.
 Internal          		:	
Files  
  Input             			:	
  Output            		: 	
Program Flow        	: 
	Keep all global setting in this file. Run this file before other files can be run.
/*____________________________________________________________________________*/

/*assign directories, folder names to global macro variables*/
/*default drive=D*/
%let data_GCTA=			D:\Now\library_genetics_epidemiology\GWAS\GCTA;
%let proj_dir=					D:\Now\library_genetics_epidemiology\slave_NU	;
%let SAS_macro=			D:\Now\library_genetics_epidemiology\SAS_macros_chang	;

/*USB drive at E or G*/
/*%let proj_dir=				G:\Now\library_genetics_epidemiology\slave_NU	;*/
/*%let SAS_macro=			G:\Now\library_genetics_epidemiology\SAS_macros_chang	;*/

%let data_raw= 				NU_data_raw	;
%let data_raw_csv= 		NU_data_raw_csv	;
%let data_pro= 				NU_data_processed	;
%let data_export=			NU_data_processed_exports	;
%let data_temp=				NU_data_temp;
%let data_test=				NU_data_test	;

%let analysis= 				NU_analytical_programs	;
%let analytical_output=	NU_analytical_output	;
%let tables_output1=		NU_tables_byDate		;
%let tables_output2=		NU2_tables_byDate	;
%let tables_output3=		NU3_tables_byDate	;
%let tables_output4=		NU4_tables_byDate	;

%let tableSupp_ouput=	NU_tableSupplementary_byDate	;
%let tableSupp_ouput2=	NU2_tableSupplementary_byDate	;
%let tableSupp_ouput3=	NU3_tableSupplementary_byDate	;
%let tableSupp_ouput4=	NU4_tableSupplementary_byDate	;

%let table_script=			NU_analytical_programs_tables	;

libname anaOut 	"&proj_dir.\&analytical_output.";
libname export 	"&proj_dir.\&data_export."	;
libname out 			"&proj_dir.\&data_pro."		;
libname in			"&proj_dir.\&data_raw."	;
libname tab			"&proj_dir.\&tables."	;
libname tem			"&proj_dir.\&data_temp";
libname test			"&proj_dir.\&data_test."	;
libname GCTA		"&data_GCTA."	;

/*assign SAS script files that convert Oracle data to SAS data sets to macro variables*/
/*Linux version directory: libname l "/mnt/lustre/home/lunC/NU/data_raw"	*/
/*Linux version directory:	libname l "K:\NU\NU_data_raw"	*/

%let load_SAS_DM_twin_info 		=	twininf_resv.sas	;
%let load_SAS_NU_nucatiaw		=	nucatiaw.sas	; 
%let load_SAS_NU_nucatidw		=	nucatidw.sas	; 
%let load_SAS_NU_nulog				=	nulog.sas	;
%let load_SAS_NU_nulog2			=	nulog2.sas	;
%let load_SAS_NU_nulog3			=	nulog3.sas	;
%let load_SAS_NU_nuqst1w			=	nuqst1w.sas;
%let load_SAS_NU_nuqst2w			=	nuqst2w.sas;
%let load_SAS_NU_online1a1w	= online1a1w.sas;
%let load_SAS_NU_online1b1w	= online1b1w.sas;
%let load_SAS_NU_online1d1w	= online1d1w.sas	;
%let load_SAS_NU_online1e1w	= online1e1w.sas	;
%let load_SAS_NU_online1fw		= online1fw.sas	;
%let load_SAS_NU_online1gw		= online1gw.sas	;
%let load_SAS_NU_online1h1w	=	online1h1w.sas	;
%let load_SAS_NU_online1j1w	= online1j1w.sas	;
%let load_SAS_NU_online1lw		= online1lw.sas	;
%let load_SAS_NU_online1mw		= online1mw.sas	;
%let load_SAS_NU_online1pw		= online1pw.sas	;
%let load_SAS_NU_online1rw		= online1rw.sas	;
%let load_SAS_NU_online1tw		= online1tw.sas	;

%let load_txt_DSM		= Nuup_AllDiagnoses_Covariates_N2881_July2016Update_outerMerge_DSM4_DSM5.txt	;
%let load_SAS_TA_forma=					TA_forma.sas		;
%let load_SAS_TA_formaw=				TA_formaw.sas	;
%let load_SAS_TA_formb=				TA_formb.sas		;
%let load_SAS_TA_formbw=				TA_formbw.sas	;
%let load_SAS_TA_talog=					talog.sas				;
%let load_SAS_TM_formaw=				TM_formaw.sas	;
%let load_SAS_TM_formbw=				TM_formbw.sas	;
%let load_SAS_TM_tmlog=				tmlog.sas			;
%let load_SAS_TM_tmsph=				TMSPH.sas		;
%let load_SAS_TW_twlog=				twlog.sas			;
%let load_SAS_TW_twsph=				TWSPH.sas		;

%let macro_01= 						reshape_wide_to_long.sas	;
%let macro_02=						tests_of_normality.sas	;
%let macro_03=						ttest_any2_groups.sas	;
%let macro_04=						SAS_to_CSV_unlabelled.sas;
%let macro_05=						CSV_to_SAS.sas	;
%let macro_06=						rename_variables.sas;	
%let macro_08=						SAS_to_CSV_with_label.sas;
%let macro_09=						def_display[1].sas;
%let macro_10=						def_groupingVar.sas	; 
%let macro_11=						rename_variables_list.sas	;
%let macro_12=						tidyUp_uniVarBinConOrd_ACEorADE.sas	;
%let macro_13=						def_sort.sas	;
%let macro_14=						data2datastep.sas; 	
%let macro_15=						every_CSV_to_one_sas7bdat.sas;
%let macro_16=						SAS_to_tab-separated_TXT.sas	;
%let macro_17=						SAS_to_space-separated_TXT.sas	;
%let macro_18=						conditionally-format-columns-rows-in-PROC-REPORT.sas ;
%let macro_19=						import_export_single_files.sas ; 
;

%include "&SAS_macro.\&macro_01.";
%include "&SAS_macro.\&macro_02.";
%include "&SAS_macro.\&macro_03.";
%include "&SAS_macro.\&macro_04.";
%include "&SAS_macro.\&macro_05.";
%include "&SAS_macro.\&macro_06.";
%include "&SAS_macro.\&macro_08.";
%include "&SAS_macro.\&macro_09.";
%include "&SAS_macro.\&macro_10.";
%include "&SAS_macro.\&macro_11.";
%include "&SAS_macro.\&macro_12.";
%include "&SAS_macro.\&macro_13.";
%include "&SAS_macro.\&macro_14.";
%include "&SAS_macro.\&macro_15.";
%include "&SAS_macro.\&macro_16.";
%include "&SAS_macro.\&macro_17.";
%include "&SAS_macro.\&macro_18.";
%include "&SAS_macro.\&macro_19.";

/*SAS formats*/
%let fmt_file_01 = NU_002_create_formats_variableExplanation.sas	;
%include "&proj_dir.\&analysis.\&fmt_file_01.";

/*assign formats to macro variables*/
%let fmt_01= 	%str($ZYGOSITY_abbr.);
%let fmt_02= 	%str($ZYGOSITY_full.);
%let fmt_03=	%str($ID_suffix.);

/*macro variables that store table titles or footnotes*/
%let table_data_01= NU_019_table_titles_footnotes.sas	;
%include "&proj_dir.\&analysis.\&table_data_01."	;

/*-----------------------------------------This is the end of this program------------------------------------------------------*/


