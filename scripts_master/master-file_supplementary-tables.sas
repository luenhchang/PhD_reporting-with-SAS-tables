/*====================================================================
Program path  			:	D:\Now\library_genetics_epidemiology\Chang_PhD_thesis\scripts\master-file_supplementary-tables.sas
Modified from			:	D:\Now\library_genetics_epidemiology\slave_NU\NU_analytical_programs\NU_020-04_tables_master_manuscript4_MR-cannabis-initiation-licit-substance-use.sas
Programmer				:	Chang
Program Language	:	SAS V9.4 	
Operating System   	:	Windows 7 professional 64bit
Date created			:	20190723
Global setting			: 	Font=TimeNewRomans, size=16
NOTE						:	(1) All 4 margins should be 2 cm per UQ thesis formatting requirement, (2) You cannot use unicodes in SAS ODS RTF table of contents as 
	table titles (see https://communities.sas.com/t5/ODS-and-Base-Reporting/Unicode-characters-in-a-TOC/td-p/151387)

___________________________________________________________________________
Purpose             		:  Execute individual SAS script files, generate supplementary tables, export them as a single RTF to use as 
									supplementary document in PhD thesis 
Run Dependencies 	: 

Macro Calls   
	External          		: 	
  	Internal          		:	
____________________________________________________________________________________________________________________________*/

/**********************************************************************************************
*Type	File
----------------------------------------------------------------------------------------------------------------------------------------
Input
Oupu		
---------------------------------------------------------------------------------------------------------------------------------------*/

/*---------------Set input or output directory-----------------------------------------------------*/
%let proj_dir=		D:\Now\library_genetics_epidemiology\slave_NU	;
%let source_script_dir= &proj_dir.\NU_analytical_programs_tables	;

%let thesis_dir=	D:\Now\library_genetics_epidemiology\Chang_PhD_thesis	;
%let SAS_script_dir= &thesis_dir.\scripts	;
%let destin_script_dir=	&thesis_dir.\SAS-supp-table-scripts	;
%let output_dir= &thesis_dir.\SAS-data-sets ;
%let report_dir= &thesis_dir.\chapter-files\supplementary-tables ;

/*---------------Run external SAS macro files-------------------------------------------------- */
%include "&proj_dir.\NU_analytical_programs\NU_001_global_setting.sas" ;
%include "&proj_dir.\NU_analytical_programs\NU_002_create_formats_variableExplanation.sas" ;

/*---------------Assign paths to SAS library------------------------------------------------ */
libname output "&output_dir." ;

/*-----------------------Create output folders-------------------------------------------------- */
options noxwait noxsync;
x "md &output_dir.";

/*---------------Copy SAS script files from manuscript directory to thesis directory------------------------------------------------*/
%sysExec xcopy "&source_script_dir.\NU*tabSup*.sas" "&destin_script_dir." /E ; 

/*Copy and rename the table title script file*/
option noxwait;
data _null_;
	X "Copy &proj_dir.\NU_analytical_programs\NU_019_table_titles_footnotes.sas &thesis_dir.\scripts\supp-table-title-text_to_SAS-macro-var.sas" ;
run;

/*----------------------------------------------------------------------------------------------------------------------------- */
/*---------------Import files for thesis chapter 2 (manuscript 1) supplementary tables----------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------------- */
/*Table S2-1*/
%let folderPath_S2_1=	D:\Now\library_genetics_epidemiology\slave_NU\NU_data_processed_exports ;
%let fileName_S2_1= 	manuscript1_count-twin-pairs.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S2_1.\&fileName_S2_1."
												,numb_rows=10
												,SAS_data_name= output.manu1_count_twin_paris); 

/*Table S2-2*/
%let folderPath_S2_2=	D:\Now\library_genetics_epidemiology\slave_NU\NU_data_processed_exports ;
%let fileName_S2_2= 	manuscript1_univariate-twin-modeling-results_binary-outcomes_model-fits.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S2_2.\&fileName_S2_2."
												,numb_rows=12
												,SAS_data_name= output.manu1_1varBin_modelFits); 
/*Table S2-3*/
%let folderPath_S2_3=	D:\Now\library_genetics_epidemiology\slave_NU\NU_data_processed_exports ;
%let fileName_S2_3= 	manuscript1_univariate-twin-modeling-results_continuous-outcomes_model-fits.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S2_3.\&fileName_S2_3."
												,numb_rows=5
												,SAS_data_name= output.manu1_1varCon_modelFits); 
/*Table S2-4*/
%let folderPath_S2_4=	D:\Now\library_genetics_epidemiology\slave_NU\NU_data_processed_exports ;
%let fileName_S2_4= 	manuscript1_univariate-ACE-ADE-modeling-results_outcomes-binary-continuous_proportion-variance-explained-by-A-C-E.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S2_4.\&fileName_S2_4."
												,numb_rows=64
												,SAS_data_name= output.manu1_1varACEADE_varianExplain); 
/*Table S2-5*/
%let folderPath_S2_5=	D:\Now\library_genetics_epidemiology\slave_NU\NU_data_processed_exports ;
%let fileName_S2_5= 	manuscript1_4var-twin-modelling-results_modelFits.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S2_5.\&fileName_S2_5."
												,numb_rows=34
												,SAS_data_name= output.manu1_4varTwinModeling_modelFits); 

/*----------------------------------------------------------------------------------------------------------------------------- */
/*---------------Import files for thesis chapter 3 (manuscript 2) supplementary tables----------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------------- */
/*Table S3-1*/
%let folderPath_S3_1=	D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\LDBasedClumping\output ;
%let fileName_S3_1= 	num-SNPs-by-CHR-meet-8-p-thresholds_QCed-GSCAN-GWAS_LD-clumping.csv; 
%ImportACommaSeparatedFile(input_file_path=  "&folderPath_S3_1.\&fileName_S3_1."
														,numb_rows=116
														,SAS_data_name= output.num_SNP_QCedGSCAN_LDclumping
														);
/*Format columns. 
Replace 0 with 99 in num_CHR for sorting purpose*/
data output.num_SNP_QCedGSCAN_LDclumping; /*115, 22*/
	set output.num_SNP_QCedGSCAN_LDclumping; 
	if num_CHR=0 then num_CHR2=99; else num_CHR2=num_CHR;
	format trait $UPCASE5. S: comma10.;
run;

/*Table S3-2*/
%let folderPath_S3_2=	D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\phenotypeData ;
%let fileName_S3_2= 	numb-target-pheno-GSCAN-PRS-associ_survived-5-signi-thresholds_manu2-QIMR19Up-everDrug1to9-AUD-CUD_sex-PRS-int-exclu_all-sex-groups.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S3_2.\&fileName_S3_2."
												,numb_rows=69
												,SAS_data_name= output.PRS_everDrug_AU_CU_multiTesting); /*  */

data output.PRS_everDrug_AU_CU_multiTesting; 
	set output.PRS_everDrug_AU_CU_multiTesting;
	format phenotype $disease_name_group2_. ;
run;

/*Table S3-3*/
%let folderPath_S3_3=	D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\GCTA\output_tabulated ;
%let fileName_S3_3= 	GCTA_wide-format_fixed-eff_SE_R2_GSCAN-PRS_QIMR-19up_everUsing10drugs-diagAU-diagCU.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S3_3.\&fileName_S3_3."
												,numb_rows=528
												,SAS_data_name= output.fixEffect_PRS_GSCAN_drug_AU_CU ); /*  */

data output.fixEffect_PRS_GSCAN_drug_AU_CU ; /*528, 41*/
	retain phenotype dup_: ; /* conditional variables must be on the left of the compute variables*/
	set output.fixEffect_PRS_GSCAN_drug_AU_CU ;
	/*duplicate p value columns for conditional formatting the estimate columns for each discovery trait*/
	dup_ai_pvalue2sided=ai_pvalue2sided;
	dup_cpd_pvalue2sided=cpd_pvalue2sided;
	dup_dpw_pvalue2sided=dpw_pvalue2sided;
	dup_sc_pvalue2sided=sc_pvalue2sided;
	dup_si_pvalue2sided=si_pvalue2sided;
	/*multiply R2 by 100 to get percentage without having to put these variables in percent format to save space*/
	ai_R2_x100=		ai_R2*100;
	cpd_R2_x100=	cpd_R2*100;
	dpw_R2_x100=	dpw_R2*100;
	sc_R2_x100=		sc_R2*100;
	si_R2_x100=		si_R2*100;
	format  phenotype $disease_name_group2_.
				ai_fix_eff_esti cpd_fix_eff_esti dpw_fix_eff_esti sc_fix_eff_esti si_fix_eff_esti 6.3
				ai_SE cpd_SE dpw_SE sc_SE si_SE 4.2
				/*Format R2 to show 2 decimal places if any p value is significant*/
				ai_R2 cpd_R2 sc_R2 dpw_R2 si_R2 percent10.2
				ai_R2_x100 cpd_R2_x100 dpw_R2_x100 sc_R2_x100 si_R2_x100 4.2 
				ai_pvalue2sided cpd_pvalue2sided dpw_pvalue2sided sc_pvalue2sided si_pvalue2sided pvalue6.4	
				/*Format sex as F, M, F+M*/
				sex_group $sexGroups3_.
				; /*name_fixEffect_pThre $pValThresholdsS1toS8_.*/
run;

/*Table S3-4*/
%let folderPath_S3_4=	D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\phenotypic-correlations ;
%let fileName_S3_4= 	phenotypic-corr-dataframe-between-GSCAN-PRS-and-targ-phenotypes-manu2-QIMR19Up-all-sex-groups.tsv ; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S3_4.\&fileName_S3_4."
												,numb_rows=176
												,SAS_data_name= output.phenoCorr_drugAUCU_GSCANPRS); /*  */

data output.phenoCorr_drugAUCU_GSCANPRS;
	set output.phenoCorr_drugAUCU_GSCANPRS;
	format 	target_phenotype $disease_name_group2_. 
				p_value_threshold $pValThresholdsS1toS8_.
				Freq_: 5.2;
run;

/*----------------------------------------------------------------------------------------------------------------------------- */
/*---------------Import files for thesis chapter 4 (manuscript 3) supplementary tables----------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------------- */

/*Table S4-1 Number phenotypes-PRS associations survived multiple testing
Sex-PRS interaction included in the models*/
%let folderPath_S4_1= D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\phenotypeData ;
%let fileName_S4_1= numb-target-pheno-GSCAN-PRS-associ_survived-5-signi-thresholds_manu3-QIMR-adults-aged20to90_GSCAN-phenotypes_9-diagnoses_sex-PRS-int-inclu.tsv; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S4_1.\&fileName_S4_1."
												,numb_rows=16
												,SAS_data_name= output.multiTestM3_sexPRS_inclu); /*  16 observations and 28 variables.*/

data output.multiTestM3_sexPRS_inclu; 
	set output.multiTestM3_sexPRS_inclu;
	format phenotype $disease_name_group2_. ;
run;

/*Table S4-2 Fixed effect estimates of GSCAN PRSs on target phenotypes per manuscript 3
Mixed models included sex*PRS interaction term
*/
%let folderPath_S4_2= 	D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\GCTA\output_tabulated ;
%let fileName_S4_2= 	GCTA_wide-format_fixed-effect-of_PRS_sex-PRS_on_QIMR-adults-aged-20-90_GSCAN-phenotypes_nicotine-alcohol-dependence-and-more_sex-PRS-int-included-in-models.tsv; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S4_2.\&fileName_S4_2."
												,numb_rows=240
												,SAS_data_name= output.fixEffPRSM3_sexPRS_inclu); /*240 observations and 26 variables.*/

data output.fixEffPRSM3_sexPRS_inclu; /*240 observations and 31 variables.*/
	*retain target_pheno_group signi_thres_T4 var_label;
	retain phenotype dup_: ; /* conditional variables must be on the left of the compute variables*/
	set output.fixEffPRSM3_sexPRS_inclu ;
/*duplicate p value columns for conditional formatting the estimate columns for each discovery trait*/
	dup_ai_pvalue2sided=ai_pvalue2sided;
	dup_cpd_pvalue2sided=cpd_pvalue2sided;
	dup_dpw_pvalue2sided=dpw_pvalue2sided;
	dup_sc_pvalue2sided=sc_pvalue2sided;
	dup_si_pvalue2sided=si_pvalue2sided;
/*Multiply R2 by 100 to get percentage without having to put these variables in percent format to save space*/
	ai_R2_x100=		ai_R2*100;
	cpd_R2_x100=	cpd_R2*100;
	dpw_R2_x100=	dpw_R2*100;
	sc_R2_x100=		sc_R2*100;
	si_R2_x100=		si_R2*100;
	format 	phenotype $disease_name_group2_.
				ai_fix_eff_esti cpd_fix_eff_esti dpw_fix_eff_esti sc_fix_eff_esti si_fix_eff_esti 6.3
				ai_SE cpd_SE dpw_SE sc_SE si_SE 4.2
				ai_R2 cpd_R2 dpw_R2 sc_R2 si_R2 percent10.2
				ai_R2_x100 cpd_R2_x100 dpw_R2_x100 sc_R2_x100 si_R2_x100 4.2
				ai_pvalue2sided cpd_pvalue2sided dpw_pvalue2sided sc_pvalue2sided si_pvalue2sided pvalue7.5	
		;
run;

/*Table S4-3 Number phenotypes-PRS associations survived multiple testing
Models stratified target sample by sex*/
%let folderPath_S4_3= 	D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\phenotypeData ;
%let fileName_S4_3= 	numb-target-pheno-GSCAN-PRS-associ_survived-5-signi-thresholds_manu3-QIMR-adults-aged-20-90-GSCAN-phenotypes_nicotine-alcohol-dependence-and-more_sex-PRS-int-exclu_all-sex-groups.tsv; 

%ImportATabSeparatedFile(input_file_path= "&folderPath_S4_3.\&fileName_S4_3."
												,numb_rows=48
												,SAS_data_name= output.multiTestM3_sexPRS_exclu); /*  48 observations and 29 variables.*/

data output.multiTestM3_sexPRS_exclu; 
	set output.multiTestM3_sexPRS_exclu;
	format phenotype $disease_name_group2_. ;
run;

/*Table S4-4 Fixed effect estimates of GSCAN PRSs on target phenotypes per manuscript 3
Models stratified target sample by sex
*/
%let folderPath_S4_4= D:\Now\library_genetics_epidemiology\GWAS\PRS_UKB_201711\GCTA\output_tabulated ;
%let fileName_S4_4= GCTA_wide-format_fixed-eff_SE_R2_GSCAN-PRS_QIMR-adults-aged-20-90_GSCAN-phenotypes_nicotine-alcohol-dependence-and-more.tsv; 
%ImportATabSeparatedFile(input_file_path= "&folderPath_S4_4.\&fileName_S4_4."
												,numb_rows=360
												,SAS_data_name= output.fixEffPRSM3_sexPRS_exclu); /*360 observations and 26 variables.*/

data output.fixEffPRSM3_sexPRS_exclu; /*360 observations and 31 variables.*/
	*retain target_pheno_group signi_thres_T4 var_label;
	retain phenotype dup_: ; /* conditional variables must be on the left of the compute variables*/
	set output.fixEffPRSM3_sexPRS_exclu ;
/*duplicate p value columns for conditional formatting the estimate columns for each discovery trait*/
	dup_ai_pvalue2sided=ai_pvalue2sided;
	dup_cpd_pvalue2sided=cpd_pvalue2sided;
	dup_dpw_pvalue2sided=dpw_pvalue2sided;
	dup_sc_pvalue2sided=sc_pvalue2sided;
	dup_si_pvalue2sided=si_pvalue2sided;
/*multiply R2 by 100 to get percentage without having to put these variables in percent format to save space*/
	ai_R2_x100=		ai_R2*100;
	cpd_R2_x100=	cpd_R2*100;
	dpw_R2_x100=	dpw_R2*100;
	sc_R2_x100=		sc_R2*100;
	si_R2_x100=		si_R2*100;
	format 	phenotype $disease_name_group2_.
				ai_fix_eff_esti cpd_fix_eff_esti dpw_fix_eff_esti sc_fix_eff_esti si_fix_eff_esti 6.3
				ai_SE cpd_SE dpw_SE sc_SE si_SE 4.2
				ai_R2 cpd_R2 dpw_R2 sc_R2 si_R2 percent10.2 
				ai_R2_x100 cpd_R2_x100 dpw_R2_x100 sc_R2_x100 si_R2_x100 4.2
				ai_pvalue2sided cpd_pvalue2sided dpw_pvalue2sided sc_pvalue2sided si_pvalue2sided pvalue7.5	
				/*Format sex as F, M, F+M*/
				sex_group $sexGroups3_.
		;
run;

/*----------------------------------------------------------------------------------------------------------------------------- */
/*---------------Import files for thesis chapter 5 (manuscript 4) supplementary tables----------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------------- */

/*Table S5-1*/
*%let folderPath_S5_1= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\observational-associations	;
*%let fileName_S5_1=		results_binary-logistic-regression_linear-regression_full-parameters.tsv	;
*%ImportATabSeparatedFile(input_file_path="&folderPath_S5_1.\&fileName_S5_1."
												,numb_rows=100
												,SAS_data_name=output.obs_assoc_full_param); /*100 observations and 17 variables*/

/*Table S5-1*/
%let folderPath_S5_1= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\LD-score-correlation\output\result-tabulated	;
%let fileName_S5_1=		LDSC-SNP-heritability_sample-size-prevalence.tsv	;
%ImportATabSeparatedFile(input_file_path="&folderPath_S5_1.\&fileName_S5_1."
												,numb_rows=10
												,SAS_data_name=output.LDSC_SNP_heritability); /*10 observations and 18 variables*/

/*Sort data by consoritum, substance and then trait*/
data output.LDSC_SNP_heritability; /* 10 observations and 14 variables.*/
	set output.LDSC_SNP_heritability; 
	format trait $var_licit_substance_use_abb. sample_size COMMA8. z 5.3 pvalue E9.; 
run; 

proc sort data=output.LDSC_SNP_heritability
				out=output.LDSC_SNP_heritability_sorted ; 
		by consortium substance trait; 
run;

/*Table S5-2*/
*%let folderPath_S5_2= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\LD-score-correlation\output\result-tabulated ;
*%let fileName_S5_2=		LDSC-SNP-heritability_sample-size-prevalence.tsv ;
*%ImportATabSeparatedFile(input_file_path="&folderPath_S5_2.\&fileName_S5_2."
												,numb_rows=10
												,SAS_data_name=output.LDSC_SNP_heritability);  /* 10 observations and 14 variables.*/

/*Table S5-2*/
%let folderPath_S5_2= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\LD-score-correlation\output\result-tabulated ;
%let fileName_S5_2=		LDSC-genetic-correlations.tsv ;
%ImportATabSeparatedFile(input_file_path="&folderPath_S5_2.\&fileName_S5_2."
												,numb_rows=45
												,SAS_data_name=output.LDSC_rG);  /* 45 observations and 15 variables.*/

/*Duplicate variable rG_p_value and order it on the left of variable rG_esti for conditional formatting*/
data output.LDSC_rG; /*45 observations and 16 variables*/
	retain dup_rG_p_value;
	set output.LDSC_rG;
	dup_rG_p_value= rG_p_value;
	format trait1_name trait2_name $var_licit_substance_use_abb. ;
run;

/*Table S5-3*/
*%let folderPath_S5_3= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\LD-score-correlation\output\result-tabulated ;
*%let fileName_S5_3= 	LDSC-genetic-correlations.tsv ;
*%ImportATabSeparatedFile(input_file_path=  "&folderPath_S5_3.\&fileName_S5_3."
												,numb_rows=45
												,SAS_data_name=output.LDSC_rG); /*45 observations and 15 variables*/

/*Table S5-3*/
%let folderPath_S5_3= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\instrument-strength ;
%let fileName_S5_3= 	proportion-MR-exposure-variance-explained-by-clumped-SNPs.tsv ;
%ImportATabSeparatedFile(input_file_path=  "&folderPath_S5_3.\&fileName_S5_3."
												,numb_rows=77
												,SAS_data_name=output.R2_clumped_exposure_SNPs);  /*  77 observations and 8 variables.*/

data output.R2_clumped_exposure_SNPs;
	set output.R2_clumped_exposure_SNPs;
	format exposure_trait $var_licit_substance_use_abb. ; 
run;

/*Table S5-4*/
%let folderPath_S5_4= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\two-sample-MR\result-tabulated ;
%let fileName_S5_4= 	heterogeneity-test_two-sample-MR-results_sorted.tsv	;
%ImportATabSeparatedFile(input_file_path=  "&folderPath_S5_4.\&fileName_S5_4."
												,numb_rows=658
												,SAS_data_name=output.heteroTest_2sampleMR); /* 657 observations and 26 variables*/

/*Duplicate variable pval_dup, Q_pval_dup and place them on the left of variable method_abbreviated for conditional formatting*/
data output.heteroTest_2sampleMR; /* 200 observations and 29 variables*/
	retain row_order pval_dup Q_pval_dup;
	length converted_effect_size_95CI $30.;	
	set output.heteroTest_2sampleMR (where=(exposure_outcome_status="reasonable two-sample MR"));
	pval_dup=pval;
	Q_pval_dup=Q_pval;
	converted_effect_size_95CI= cat(put(effect_size_estimate, 5.3), " [ ", put(effect_size_LBound, 5.3)," , " ,put(effect_size_UBound, 5.3)," ]");
	format 	exposure outcome $var_licit_substance_use_abb.
				exposure_clumping_p1 E7.
				Q_pval pval E9. ;
run;

/*Table S5-5*/
%let folderPath_S5_5= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\MR-PRESSO\result-tabulated ;
%let fileName_S5_5= 	MR-PRESSO-global-test-results.tsv	;
%ImportATabSeparatedFile(input_file_path=  "&folderPath_S5_5.\&fileName_S5_5."
												,numb_rows=10
												,SAS_data_name=output.MR_PRESSO_results); /* 8 observations and 13 variables.*/
data output.MR_PRESSO_results; /*8 observations and 16 variables.*/
	retain pval_dup;
	set output.MR_PRESSO_results; 
	if pval not=. then 
		do;
			converted_effect_size_95CI= cat(put(effect_size_estimate, 5.3), " [ ", put(effect_size_LBound, 5.3)," , " ,put(effect_size_UBound, 5.3)," ]");
		end;
	else if pval =. then 
		do;
			converted_effect_size_95CI="";
		end;
	 pval_dup=pval;
	 if MR_analysis="Outlier-corrected" then MR_analysis_revised="MR-PRESSO global test with outliers removed";
	 else if MR_analysis="Raw" then MR_analysis_revised="MR-PRESSO global test";
	format exposure outcome $var_licit_substance_use_abb. ;
run;

/*Table S5-6*/
%let folderPath_S5_6= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\two-sample-MR\result-tabulated ;
%let fileName_S5_6= 	leave-one-SNP-out-analysis-results_association-GSCAN-smoking-initiation_on_UKB-caffeine-consumed-per-day.tsv	;
%ImportATabSeparatedFile(input_file_path=  "&folderPath_S5_6.\&fileName_S5_6."
												,numb_rows=68
												,SAS_data_name=output.MRLOO_GSCANSI_UKBECCPD); /* 68 observations and 25 variables.*/

data output.MRLOO_GSCANSI_UKBECCPD; /*  68 observations and 29 variables.*/
	retain p_1e5_dup significant_1e5 p_5e8_dup significant_5e8;
	set output.MRLOO_GSCANSI_UKBECCPD; 
	if p_1e5 not=. then 
		do;
			converted_effect_size_95CI_1e5= cat(put(effect_size_estimate_1e5, 5.3), " [ ", put(effect_size_LBound_1e5, 5.3)," , " ,put(effect_size_UBound_1e5, 5.3)," ]");
		end;
	if p_5e8 not=. then 
		do;
			converted_effect_size_95CI_5e8 = cat(put(effect_size_estimate_5e8, 5.3), " [ ", put(effect_size_LBound_5e8, 5.3)," , " ,put(effect_size_UBound_5e8, 5.3)," ]");
		end;
	p_1e5_dup=p_1e5;
	p_5e8_dup=p_5e8;
	format  exposure outcome $var_licit_substance_use_abb. 
				b_1e5 se_1e5 se_5e8 b_5e8 5.3
				p_1e5 p_5e8 E7.;
run;

/*Table S5-7 Phenotypic associations to benchmark MR analysis
Phenotypic association predictors should match MR exposures 
Phenotypic association outcomes should match MR outcomes 
*/
%let folderPath_S5_7= 	D:\Now\library_genetics_epidemiology\GWAS\MR_ICC_GSCAN_201806\observational-associations	;
%let fileName_S5_7=		phenotypic-association-results_outcomes-predictors-matched-MR-outcomes-exposures.tsv	;
%ImportATabSeparatedFile(input_file_path="&folderPath_S5_7.\&fileName_S5_7."
												,numb_rows=357
												,SAS_data_name=output.obs_assoc_full_param); /*357 observations and 17 variables.*/

/*Duplicate p value and place it on the left of predictor_label column for the purpose of conditional highlighting*/
data output.obs_assoc_full_param2;  /*336 observations and 19 variables.*/
	retain dup_p_value ;
	set output.obs_assoc_full_param (where= (predictor not in ("Intercept")));
	dup_p_value=p_value ;
	converted_effect_size_95CI= cat(put(effect_size_estimate, 5.3), " [ ", put(effect_size_LBound, 5.3)," , " ,put(effect_size_UBound, 5.3)," ]");
	if 	(dep_var="X20160_recode" and predictor="merged_pack_years_20161") or 
		(dep_var="merged_pack_years_20161" and predictor="X20160_recode") then do;
		dup_p_value=.;
		p_value=.;
		converted_effect_size_95CI="NC";
	end;
	format 	dep_var predictor $manu4_predictors. p_value E7. b 7.3;  /*dep_var_label $var_licit_substance_use_abb. */
run;

/*Sort data by model, dependent variables, and then predictor*/
proc sort data=output.obs_assoc_full_param2; 
	by row_order; 
run;


/*-----------------------------------------------------------------------------------------------------------------------*/
/* Export supplementary table files as a RTF-----------------------------------------------------------------------*/
/* ref systemp option NOQUOTELENMAX : http://support.sas.com/resources/papers/proceedings11/262-2011.pdf*/
/*-----------------------------------------------------------------------------------------------------------------------*/

options /* PAGENO=214  Starting page number for the next page*/ 	
			missing = ' '  	/*Specifies the character to print for missing numeric values.*/ 
			center 			/*Specifies whether to center or left align SAS procedure output*/
			nodate 			/*suppress default print of data time that this SAS program executed*/
			nonumber 	/*nonumber: suppress default print of page number on first title line of each page*/
			orientation=	landscape /*orientation=portrait */			
		;
TITLE1; TITLE2;
/*------------------------------------------------------changing table margins------------------------------------------------------*/
options	bottommargin = 	2 cm 
   		topmargin = 			2 cm 
   		rightmargin = 			2 cm 
   		leftmargin = 			2 cm 
		; 

/*suppress the warning that a quoted string that exceeds 262 characters in length*/
options NOQUOTELENMAX ; 

/*Store table title text CSV file in SAS macro variables and values*/
%include	"&SAS_script_dir.\supp-table-title-text_to_SAS-macro-var.sas" ;
%include	"&SAS_script_dir.\import_supplementary-table_table-of-contents.sas" ; 

/* first tell ODS what character will be used as the ODS ESCAPECHAR character value*/
ods escapechar='~';
ods escapechar='^';

ods _all_ close; 

ods rtf file=		"&report_dir.\PhD-thesis_supplementary-tables_%sysfunc(date(), yymmdd10.).rtf" 
		style=		Journal
		contents toc_data  /*contents toc_data:  show table of contents (TOC). Active TOC changed pageno= back to 1*/
		 ; 

/*----------------START 	chapter2 supplementary tables------------------------*/

/*------binary count in MZ twin1, MZ twin2, DZ twin1, DZ twin2-----------------------------------*/
%let table_order	=	1;
%let tData_uniVarBin_t1t2Count=		output.manu1_count_twin_paris ; 
%let tScript_uniVarBin_t1t2Count=	Ch2_tabSup01_count-twin-pairs_binary-outcomes; 
%include	"&destin_script_dir.\&tScript_uniVarBin_t1t2Count..sas";

/*-------------univar saturated model fit values of binary variables-------------*/
/*each model fit in wide format with significance indicated by superscript a*/
%let table_order	=	2	;
%let tData_1varBin_difLL_signiSuper =	output.manu1_1varBin_modelFits ;
%let tScript_1varBin_difLL_signiSuper =	Ch2_tabSup02_1VarBin_basiAssum_difLL_significance;
%include	"&destin_script_dir.\&tScript_1varBin_difLL_signiSuper..sas";

/*-------------univar saturated model difference in log-likelihood for continuous variables--------*/
/*each model fit in wide format with significance indicated by superscript a*/
%let table_order	=	3	;
%let tData_1varCon_difLL_signiSuper =	output.manu1_1varCon_modelFits ;
%let tScript_1varCon_difLL_signiSuper =	Ch2_tabSup03_1VarCon_basiAssum_difLL_significance; 
%include	"&destin_script_dir.\&tScript_1varCon_difLL_signiSuper..sas";
/*------------------1 variate ACE and ADE from binary, continuous variables-----------------------------------*/
/*%let where_condition= 						%str( (comparison2='ACE' and p=.) OR (p > 0.05)  );*/
%let table_order	=	4	;
%let tData_uniVBinCon_ACE_ADE=	output.manu1_1varACEADE_varianExplain ; 
%let tScript_uniVBinCon_ACE_ADE= 	Ch2_tabSup04_1VarBinCon_ACE_ADE; 
%include	"&destin_script_dir.\&tScript_uniVBinCon_ACE_ADE..sas"	;
/*------------------4 variate ACE model fits-----------------------------------*/
%let table_order	=	5	;
/*%let where_condition=%str(depVarGroup=5)	;*/
%let tData_4Var_mFits= 	output.manu1_4varTwinModeling_modelFits	;
%let tScript_4Var_mFits= 	Ch2_tabSup05_4Var_P6rS6rAFFrSUDr_mFits	;
%include	"&destin_script_dir.\&tScript_4Var_mFits..sas"	;
/*----------------END 		chapter2 supplementary tables------------------------*/

/*----------------START 	chapter3 supplementary tables------------------------*/
/*------number of SNPs that meet each of 8 association p value thresholds after QC and after clumping----------------------*/
%let table_order	=	1;
%let tData_numSNP_QCGSCAN_LDClumped=	output.num_SNP_QCedGSCAN_LDclumping ; 
%let tScript_numSNP_QCGSCAN_LDClumped=	Ch3_tabSup01_numSNPs_QCed-GSCAN-GWAS_LDClumped; 
%include	"&destin_script_dir.\&tScript_numSNP_QCGSCAN_LDClumped..sas";

/*----number of GSCAN-PRS-target-phenotype associations with p values lower than 5 p values adjusted for multiple testing*/
%let table_order	=2;
%let tData_multiple_testing=		output.PRS_everDrug_AU_CU_multiTesting ; 
%let tScript_multiple_testing=	Ch3_tabSup02_account-for-multiple-testing_associations-GSCAN-PRS-everDrug1to9-AUD-CUD; 
%include	"&destin_script_dir.\&tScript_multiple_testing..sas";

/*--- effect estimates (beta, SE, p value, R2) of GSCAN PRS on variation of initiating illegal drug, alchol disorders, cannabis disorders */
%let table_order	=3;
%let tData_fixed_effect_PRS=	output.fixEffect_PRS_GSCAN_drug_AU_CU ; 
%let tScript_fixed_effect_PRS=	Ch3_tabSup03_fixed-effect-etimates-GSCAN-PRSs-on_illicit-drug-AU-CU-QIMR19Up; 
%include	"&destin_script_dir.\&tScript_fixed_effect_PRS..sas";

/*--- Phenotypic correlation between GSCAN PRS and target phenotypes ---*/
%let table_order	=4;
%let tData_pheoCorr_PRS_targetPheno =		output.phenoCorr_drugAUCU_GSCANPRS ; 
%let tScript_pheoCorr_PRS_targetPheno = 	Ch3_tabSup04_phenotypic-correlation-between-GSCAN-PRSs-and-illicit-drug-AU-CU-QIMR19Up;
%include	"&destin_script_dir.\&tScript_pheoCorr_PRS_targetPheno..sas";
/*----------------END 		chapter3 supplementary tables------------------------*/

/*----------------START chapter4 supplementary tables------------------------*/
/*Number of associations survived multiple testing by five different thresholds
		Modelling contains sex*PRS interaction term
*/
%let table_order	=1;
%let tData_multiple_testing=		output.multiTestM3_sexPRS_inclu; 
%let tScript_multiple_testing=	Ch4_tabSup01_account-for-multiple-testing_associations_GSCAN-PRS_QIMR-middle-aged-adults_GSCAN-phenotypes_9-diagnoses_sexPRS-int-included; 
%include	"&destin_script_dir.\&tScript_multiple_testing..sas";

/*Effect estimates (beta, SE, p value, R2) of GSCAN PRS on variation of target phenotypes per manuscript 3
		Modelling contains sex*PRS interaction term
*/
%let table_order	=2;
%let tData_fixed_effect_PRS=output.fixEffPRSM3_sexPRS_inclu;
%let tScript_fixed_effect_PRS= Ch4_tabSup02_fixed-effect-etimates-GSCAN-PRSs-on_GSCAN-phenotypes-QIMR-middle-aged-adults_sex-PRS-int-included ;
%include	"&destin_script_dir.\&tScript_fixed_effect_PRS..sas";

/*Number of associations survived multiple testing by five different thresholds
		Modelling stratified target sample by sex (into females, males and both sexes together)
*/
%let table_order	=3;
%let tData_multiple_testing=	output.multiTestM3_sexPRS_exclu; 
%let tScript_multiple_testing=	Ch4_tabSup03_account-for-multiple-testing_associations_GSCAN-PRS_QIMR-middle-aged-adults_GSCAN-phenotypes_9-diagnoses_sexPRS-int-excluded; 
%include	"&destin_script_dir.\&tScript_multiple_testing..sas";

/*Effect estimates (beta, SE, p value, R2) of GSCAN PRS on variation of target phenotypes per manuscript 3
		Modelling stratified target sample by sex (into females, males and both sexes together)
*/
%let table_order	=4;
%let tData_fixed_effect_PRS=	output.fixEffPRSM3_sexPRS_exclu ; 
%let tScript_fixed_effect_PRS=	Ch4_tabSup04_fixed-effect-etimates-GSCAN-PRSs-on_GSCAN-phenotypes-QIMR-middle-aged-adults_sex-PRS-int-excluded; 
%include	"&destin_script_dir.\&tScript_fixed_effect_PRS..sas";
/*----------------END chapter4 supplementary tables--------------------------*/

/*----------------START chapter5 supplementary tables------------------------*/
/*Table S5-1	:	Observation associations of substance use phenotypes in the UKB using either logistic or linear regression------ */
*%let table_order	= 1;
*%let tData_observ_assoc=	 output.obs_assoc_full_param2 ; 
*%let tScript_observ_assoc= Ch5_tabSup01_observational-association-results ; 
*%include	"&destin_script_dir.\&tScript_observ_assoc..sas";

/*Table S5-1	:	SNP heritability estimates and sample sizes of GWAS files*/
%let table_order	= 1;
%let tData_SNP_heritability=	 output.LDSC_SNP_heritability_sorted ; 
%let tScript_SNP_heritability= Ch5_tabSup01_GWAS-sample-size-prevalence_LDSC-SNP-heritability-estimates; 
%include	"&destin_script_dir.\&tScript_SNP_heritability..sas";

/*Table S5-2	:	genetic correlations between GWAS on substance use or initiation (45 tests)*/
%let table_order	= 2;
%let tData_genetic_correlations=	output.LDSC_rG; 
%let tScript_genetic_correlations= Ch5_tabSup02_LDSC-genetic-correlation-results; 
%include	"&destin_script_dir.\&tScript_genetic_correlations..sas";

/*Table S5-3: genetic correlations between GWAS on substance use or initiation (45 tests)*/
*%let table_order	=	3; /*value of &table_order corresponds to number of table title text in the table_tile_text.csv*/
*%let tData_genetic_correlations=	output.LDSC_rG; 
*%let tScript_genetic_correlations= Ch5_tabSup03_LDSC-genetic-correlation-results; 
*%include	"&destin_script_dir.\&tScript_genetic_correlations..sas";

/*Table S5-3: Proportion of exposure variance explained by genetic instruments*/
%let table_order	=	3; /*value of &table_order corresponds to number of table title text in the table_tile_text.csv*/
%let tData_instrument_strength=	 output.R2_clumped_exposure_SNPs; 
%let tScript_instrument_strength= Ch5_tabSup03_proportion-exposure-variance-explained-by-clumped-SNPs; 
%include	"&destin_script_dir.\&tScript_instrument_strength..sas";

/*Table S5-4: two-sample MR results on all exposure-outcome trait pairs (220 tests)*/
%let table_order	= 4;
%let tData_hetero_2sampleMR=	output.heteroTest_2sampleMR ; 
%let tScript_hetero_2sampleMR=  Ch5_tabSup04_heterogeneity-test_two-sample-MR-results; 
%include	"&destin_script_dir.\&tScript_hetero_2sampleMR..sas";

/*Table S5-5 MR-PRESSO results*/
%let table_order	= 5;
%let tData_MRPRESSO=	 output.MR_PRESSO_results ; 
%let tScript_MRPRESSO= Ch5_tabSup05_MR-PRESSO_results ; 
%include	"&destin_script_dir.\&tScript_MRPRESSO..sas";

/*Table S5-6 MR leave-one-SNP-out on causal association between GSCAN SI and UKB caffeine*/
%let table_order	= 6;
%let tData_MR_leave_one_out=	output.MRLOO_GSCANSI_UKBECCPD ; 
%let tScript_MR_leave_one_out= 	Ch5_tabSup06_MR-leave-one-out-analysis_results ; 
%include	"&destin_script_dir.\&tScript_MR_leave_one_out..sas";

/*Table S5-7	:	phenotypic associations of substance use phenotypes in the UKB using either logistic or linear regression------ */
%let table_order	= 7;
%let tData_observ_assoc=	 output.obs_assoc_full_param2 ; 
%let tScript_observ_assoc= Ch5_tabSup07_observational-association-results; 
%include	"&destin_script_dir.\&tScript_observ_assoc..sas";

/*---------------------END chapter5 supplementary tables------------------------*/
/*------------------ close ODS RTF device----------------------------------------------------*/
ods rtf close;
ods listing;


/*----------------------------------------------------This is the end of this program-----------------------------------------------------------------*/
