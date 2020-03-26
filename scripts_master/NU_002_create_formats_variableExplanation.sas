/*===============================================================================
Program Name  		:  NU_002_create_formats_variableExplanation.sas
Path                			:  
Program Language	:  SAS V9.4 	
Operating System    :  Win7 64bit
Date created			:	20160529
Note							: 	
	(1) If you do not use the library = option on the proc format statement, the formats are by default stored in 
		work.formats and exist only for the current SAS session. If you specify only a libref, the formats are 
		permanently stored in libref.formats.
	(2) format name cannot end in a number
_______________________________________________________________________________________
Purpose             		:  create formats similar to 
Run Dependencies	:  NU_005_cronbach_coefficient_alpha.R
Macro Calls   
	External          		: 	
  	Internal          		:	
Files  
  Input             			:	
  Output            		: 	
Program Flow        	: 
    1. run this file before the self-defined formats can be appiled in other files
	2. place formats in an alphabetic order similar to NIS variable names
	3. format names can't end with a number so an underscore has been added
--------------------------------------------------------------------------------------------------------------------------------------
variable		Explanation
--------------------------------------------------------------------------------------------------------------------------------------
ID/TWID		
	(1) family w/ MULTIB=2 and 3 IDs w/ suffix 01, 02, 50. 50 is the non-twin sibling older than 01, 02
	(2) family w/ MULTIB=3 and 3 IDs w/ suffix 01, 02, 50, the 3 ID are same-aged
	(3) family w/ MULTIB=3 and 4 IDs w/ suffix 01, 02, 50, 51. '51' is non-twin sibling older than 01, 02, 50. 01, 02 and 50 are same-aged
	(3) family w/ MULTIB=4 and 5 IDs w/ suffix 01, 02, 50, 51, 52. '52' is non-twin sibling older than 01, 02, 50, 51.
	01, 02, 50, 51 are same-aged 

EQSTART captured the time of entering the survey page.

EQEND captured the time when a participant clicked the finish button. If a participant had answered SPHERE 
	questions and then quit the survey without clicking the finish button, his EQEND would be missing. 

ID EQSTART SPHERE12 EQEND	Explanation
-----------------------------------------------------------
A		Y				.			  	  .				see exp1
A		Y				Y				  .				see exp2 
B		Y				Y				 Y				see exp3 
-----------------------------------------------------------
exp1: person A entered survey but didn't answer SPHERE questions, nor did he click finish button	
exp2: person A answered SPHERE questions but didn't click finish button
exp3: person B answered SPHERE questions and clicked finish button

MULTIB		Number of infants born together. Triplets when MULTIB=3.

ZYGOSITY	(1) values should be exactly the same in twin1 (ID suffix=01) and twin2 (ID suffix=02), termed 
	concordant zygosity. Otherwise discordant zygosity, should be reported to Kerrie. 
	(2) ZYGOSITY is not necessarily the same among triplets. zygosity of twin1 (ID suffix=01) is absoluted whereas zygosity 
	of twin2 (ID suffix=02), and ID suffix=50 is determined based on how they are related to twin1. 
	So there may be ZYGOSITY=1,1,3 where twin1 and twin2 are MZFF, and twin1 and ID suffix=50 are DZFF
____________________________________________________________________________*/

/*---------------------------------------formats for numeric values-------------------------------------------*/
proc format	; 
	value ENDSTAT
		1 = 'complete'
		15 = 'incomplete	refused'
		16 = 'refused - hostile'
		17 = 'refused - non-hostile (polite, busy etc)'
		20 = 'lost contact'
		21 = 'dead'
		22 = 'invalid (eg relative filled out questionnaire)'
		23 = 'incapable (eg senile, demented)'
		25 = 'partial completion'
		27 = 'overseas'
		50 = 'return to sender'	
		51 = 'telephone contact'	
		61 = 'doctor refused patient contact'
		;

value ENDSTAT_NU3_
		1 = 'Interview completed' 
		2 = 'Interview partially completed' 
		3 = 'Interview in progress' 
		4 ='Completed under other ID' 
		5 = 'Unable to contact' 
		6 = 'Project Closure ? in progress' 
		7 = 'Project Closure ? no contact made' 
		8 = 'Project Closure ? 12month + outstanding' 
		19 = 'Lead given to IVER' 
		20 = 'Lost Contact' 
		21 = 'Deceased' 
		22 = 'ineligible' 
		23 = 'Incapable' 
		24 = 'No interview - exceptional cases/circumstances' 
		25 = 'No telephone' 
		26 = 'Silent number' 
		27 = 'Overseas' 
		50 = 'Return to sender' 
		51 = 'Sibling and twin overlap - check ATR' 
		54 = 'Silent number/no telephone/letter sent' 
		55 = 'Delay contact - study crossover' 
		56 = 'Delay contact' 
		58 = 'Deleted at PI request' 
		59 = 'Sibling ineligible - outside age limit' 
		60 = 'Refused by screening twin' 
		61 = 'Refusal - positive (1)' 
		62 = 'Refusal - mildly negative (2)' 
		63 = 'Refusal - moderately negative (3)' 
		64 = 'Refusal - very negative (4)' 
		65 = 'Refusal - extremely negative (5)' 
		68 = 'Refusal ? passive' 
		88 = 'Absolutely lost (Family/ATR/Telstra)'
		;
/*Format numbers as leading zeros deleted if < 0 (e.g. 0.01 will be formatted as .01, -0.01 as -.01,  no change for 1.01, -1.01)
Source: https://v8doc.sas.com/sashtml/proc/zpicture.htm*/
	picture nozeros
           low -  -1  =  '00.00' 
              (prefix='-')
           -1 <-<  0  =     '99' 
              (prefix='-.' mult=100)
            0  -< 1   =     '99'
              (prefix='.'  mult=100)
            1  - high =  '00.00'
	;

/*nonmissing numeric will preserve its decimal places. See https://communities.sas.com/t5/Base-SAS-Programming/Replacing-numeric-missing-variable-value-with-NA/td-p/389202*/
	value numericMissingAsNA
		. = "          NA"
		other = [best12.]
		;	
/*This applies to 1 digit numeric variables only. Don't apply it to normal numeric variables. Incorrect formatting returns a star sign.
		For example, this format applied to 2 digit numeric*/
	value num_1digit_MissingAsNA
		. = "NA"
		other = [best1.]
		;
/*This applies to 1 to 2 digit numeric variables only. Don't apply it to normal numeric variables*/
	value num_2digit_MissingAsNA
		. = "NA"
		other = [best2.]
		;
	value pValue_color1_ /*p<0.001 in red, else in black*/
	    low - 0.001= 'red' 
	    0.001 <- high = 'black'
		; 

	value studyNameManuscript01_
		1='TW1'
		2='TW2'
		3='TM'
		4='TA'
		5='NU'
		6='NU diagnoses'
		;
/*---------------------------------------formats for character values-------------------------------------------*/
	value $BLTS_studyCodeExplain
		'TW1'= 	'TW1 (Moles 1)'
		'TW2'= 	'TW2 (Moles 2)'
		'TM'=		'TM (Memory, attention, problem solving)'
		'TA'=		'TA (Laterality, personality, reading…)'
		'NU'=		'NU (19 Up)'
		'TU'=		'TU (25 Up)'
		;
	value $disease_name_group1_
		'Me_DSM5MDD_ori'=							'Major depressive disorder'
		'Me_DSM5agoraphobia_ori'=					'Agoraphobia'
		'Me_DSM5depressiveEpisode_ori'=		'Ever had depressive episodes'
		'Me_DSM5hypomanicEpisode_ori'=		'Ever had hypomanic episodes'
		'Me_DSM5manicEpisode_ori'=				'Ever had manic episodes'
		'Me_DSM5panicDisorder_ori'=				'Panic disorder'
		'Me_DSM5psychoSympPresence_ori'=	'Prescense of psychosis symptoms'
		'Me_DSM5socialAnxiety_ori'=				'Social anxiety'
		;
	value $disease_name_group2_
		'SU_DSM4alcoholAbuse_ori'=				'Alcohol abuse' 
		'SU_DSM4alcoholDepend_ori'=				'Alcohol dependence' 
		'SU_DSM4cannabisAbuse_ori'=				'Cannabis abuse' 
		'SU_cannabis_abuse_onset'=					'Age at onset of cannabis abuse'
		'SU_DSM4cannabisDepend_ori'=			'Cannabis dependence'
		'SU_cannabis_dependence_onset'=			'Age at onset of cannabis dependence'
		'SU_DSM5alcoholUD_ori'=					'DSM5 AUD (4 point scale)'
		"SU_DSM5alcoholUD_0or1vs2or3"=	'DSM5 AUD (ctrl mild vs moderate severe)'
		'SU_DSM5alcoholUD_0vs1'=					'DSM5 AUD ctrl vs mild'   
		'SU_DSM5alcoholUD_0vs1or2or3'=		"DSM5 AUD ctrl vs cases"   
		'SU_DSM5alcoholUD_0vs2'=					"DSM5 AUD ctrl vs moderate" 
		'SU_DSM5alcoholUD_0vs3'=					"DSM5 AUD ctrl vs severe"
		'SU_DSM5cannabisUD_ori'=					"DSM5 CUD (4 point scale)" 
		'SU_DSM5cannabisUD_0or1vs2or3'=	"DSM5 CUD (ctrl mild vs moderate severe)" 
		'SU_DSM5cannabisUD_0vs1'=				"DSM5 CUD ctrl vs mild"
		'SU_DSM5cannabisUD_0vs1or2or3'=	"DSM5 CUD ctrl vs cases" 
		'SU_DSM5cannabisUD_0vs1or2or'=		"DSM5 CUD ctrl vs cases"  
		'SU_DSM5cannabisUD_0vs2'=				"DSM5 CUD ctrl vs moderate" 
		'SU_DSM5cannabisUD_0vs3'=				"DSM5 CUD ctrl vs severe"
		'SU_cannabis_use_disorder_onset'=		"Age at onset of DSM5 CUD"	
		'everDrug1'=									"Ever used cocaine"
		'everDrug2'=									"Ever used amphetamine"
 		'everDrug3'=									"Ever used inhalants"
		'everDrug4'=									"Ever used sedatives"
		'everDrug5'=									"Ever used hallucinogens"
		'everDrug6'=									"Ever used opioids"
		'everDrug7'=									"Ever used ecstasy"
		'everDrug8'=									"Ever used prescription pain killers"
		'everDrug9'=									"Ever used prescription stimulants"   
		'everDrug10'=									"Ever used other illicit drugs"
		'SU_cannabis_ever'=						"Ever used cannabis"
		'SU_cannabis_onset'=						"Age at onset of cannabis initiation"
		'alcoholEver'=									'Ever used alcoholic beverages'
		'alcoholAgeFirst'=							"Age at using first alcoholic beverage"
		"alcoholFreq"=								"Alcohol frequency"
		"numDrinksPerDay"= 						"Number of drinks per day"
		'tobaccoEver'=									'Ever used tobacco products'
		'tobaccoAgeFirst'=							'Age at using first tobacco product'
		"tobaccoFreq"= 								"Tobacco frequency" 
		"numCigarePerDay"=  					"number of cigarettes per day"
		"GSCAN_Q2_recode"=					"Smoking initiation"
		"GSCAN_Q4"=								"Age at starting regular smoking"
		"GSCAN_Q1"=								"Cigarettes per day"
		"GSCAN_Q3_recode"=					"Smoking cessation"
		"GSCAN_Q6_recode"=					"Drinking initiation"
		"GSCAN_Q5_Drinks_per_week"=	"Drinks per week"	
		"alcdep4"=										"DSM-IV alcohol dependence"
		"nicdep4"=										"DSM-IV nicotine dependence"
		"ftnd_dep"=										"FTND-based nicotine dependence"
		"dsmiv_conductdx"=						"DSM-IV conduct disorder"
		"aspddx4"=										"DSM-IV antisocial personality disorder"
		"depdx"=											"DSM-IV major depressive disorder"
		"panic4"=										"DSM-IV panic disorder"
		"sp_dsm4"=										"DSM-IV social anxiety disorder"
		"mania_scrn"=									"Mania screen"
		"Numb_target_pheno_predicted"=  "Number target phenotypes predicted"
		;

	value $ID_suffix
		'01' = 'twins'
		'02' = 'twins'
		'53' = 'parents'
		'54' = 'parents'
		'50' = 'siblings'
		'51' = 'siblings'
		;
	value $charMissingAsNA
		' '= 'NA'
		;	
	value $manu4_predictors
		'caffeine.per.day'=							'Caffeine consumed per day'
		'complete_alcohol_unitsweekly'=	'Estimated standard drinks per week'	
		'age'=												'Age'
		'inferred.sex'=									'Sex'
		'overall_health_rating'=					'Overall health rating'
		'quali.edu.6138.recoded.z.score'=	'Educational attainment'
		'TDI'=												'Townsend deprivation index'
		'X20116_recodeFinal'=					'Smoking status'
		'X20116_recodeFinal_0_1'=			'Smoking cessation'
		'X20160_recode' =							'Smoking initiation'
		'merged_pack_years_20161'=			'Pack years of smoking'
		'X20453_0_0_recoded'=					'Cannabis initiation'
		'X3436_recodeMean'= 					'Age at starting smoking in current smokers'
		'X3456.0.0'=									'Cigarettes per day'
		;
	value $openmxModelNames
		'CholACE'=	'Cholesky ACE'
		'IndACE'=	'IP'
		'Ind2Ace'=	'IP2A'		
		'Ind3Ace'=	'IP3A'
		'ComACE'=	'CP'
		;
	value $NU_phase
		'NU.NULOG'=				'NU1'
		'NU.NULOG2'=			'NU2'
		'NU.NULOG3'=			'NU3'
		'NU.NULOG_pooled'=	'All waves'
		;
/*format for manuscript 01 supplementary table S6*/
	value $NUtabSup05_2varModelFits 
/*continuous variables*/
		'PSYCH6_r'							=	'PSYCH6 summed score' 
		'PSYCH6_IRT_r'					=	'PSYCH6 IRT score' 
		'SOMA6_r'							=	'SOMA6 summed score ' 
		'SOMA6_IRT_r'					=	'SOMA6 IRT score ' 
		'IRT_affectDisorders_r'			=	'AD IRT score'
		'IRT_substanceUse_r'		=	'SU IRT score'
			;
	value $SPHERE12_questions
		"omitSPHERE12Item01"=		"1. Feeling nervous or tense?" 
		"omitSPHERE12Item02"=		"2. Feeling unhappy and depressed?"
		"omitSPHERE12Item03"=		"3. Feeling constantly under strain?"
		"omitSPHERE12Item04"=		"4. Everything getting on top of you?"
		"omitSPHERE12Item05"=		"5. Losing confidence?"
		"omitSPHERE12Item06"=		"6. Being unable to overcome difficulties?"
		"omitSPHERE12Item07"=		"7. Muscle pain after activity?"
		"omitSPHERE12Item08"=		"8. Needing to sleep longer?"
		"omitSPHERE12Item09"=		"9. Prolonged tiredness after activity?"
		"omitSPHERE12Item10"=		"10. Poor sleep?"
		"omitSPHERE12Item11"=		"11. Poor concentration?"
		"omitSPHERE12Item12"=		"12. Tired muscles after activity?"
			;

/*These formats are used in manuscript 4 */
	value $var_licit_substance_use_abb
			'AI'= 						'Age of initiation of regular smoking'
			'GSCAN-AI'= 			'Age of initiation of regular smoking'
			'CCPD'=					'Cups of coffee consumed per day'
			'UKB-CCPD'=			'Cups of coffee consumed per day'
			'caffeine'=				'Caffeine consumed per day'
			'ECCPD'=				'Caffeine consumed per day'
			'UKB-ECCPD'=		'Caffeine consumed per day'
			'CI'=							'Cannabis initiation'
			'CPD'=						'Cigarettes smoked per day'
			'GSCAN-CPD'=		'Cigarettes smoked per day'
			'UKB-CPD'=			'Cigarettes smoked per day'
			'DPW'=					'Drinks consumed per week'
			'GSCAN-DPW'=		'Drinks consumed per week'
			'ESDPW'=				'Estimated standard drinks per week'
			'UKB-ESDPW'=		'Estimated standard drinks per week'
			'PYOS'=					'Pack years of smoking'
			'UKB-PYOS'=			'Pack years of smoking'
			'SC'=						'Smoking cessation'
			'GSCAN-SC'=			'Smoking cessation'
			'SI'=							'Regular smoking initiation'
			'GSCAN-SI'=			'Regular smoking initiation'
			;

/*These formats are to be used with varGroup in file "ROut_NU_allDiagnoses_varNames.xlsx"	*/
/*These formats do not uniquely identify variable values*/
	value $var_P6_S6_AFF_SUD
/*binary diagnoses*/
		'agoraphobia_DSM5'=				'agoraphobia'
		'AlcoholEver'=						'alcohol use'
		'depressiveEpisode_DSM5'=	'depressive episodes'

/*recode dsm5_AUD as 0 if control or mild, as 1 if moderate or severe*/
		'dsm5_AUD_bin1'=					'alcohol use disorder' 

/*recode dsm5_AUD as 0 if control, mild, moderate,  as 1 if severe*/
		'dsm5_AUD_bin2'= 					'alcohol use disorder severity'
		'dsm5_AUD'= 							'alcohol use disorder'
		'dsm5_CUD_binary'=				'cannabis use disorder'
		'dsm5_CUD'=							'cannabis use disorder'
		'hypomanicEpisode_DSM5'=	'hypomanic episodes'
		'IllegalDrugsEver'=					'drug use ever'
		'MarijuanaEver'=						'cannabis use ever'
		'MDD_DSM5'=						'major depressive disorder'
		'panicAttack'=							'panic attack'
		'panicDisorder_DSM5'=			'panic disorder'
		'PsychosisLast12months'=		'psychosis symptoms last 12 months'
		'PsychosisSymptomPresence'=	'psychosis symptoms lifetime'
 		'socialAnxietyDiag_DSM5'=	'social anxiety' 
		'TobaccoEver'=							'tobacco use ever'

/*continuous variables*/
		'AnxDep6Final_theta_13'			=	'<13'
		'AnxDep6Final_theta_13_r'			=	'<13'
		'AnxDep6Final_theta_13_15'		=	'13-15'
		'AnxDep6Final_theta_13_15_r'	=	'13-15'
		'AnxDep6Final_theta_15_17'		=	'15-17'
		'AnxDep6Final_theta_15_17_r'	=	'15-17'
		'AnxDep6Final_theta_17'			=	'17-19'
		'AnxDep6Final_theta_17_r'			=	'17-19'
		'PSYCH6'									=	'summed score'
		'PSYCH6_r'									=	'summed score'
		'PSYCH6_IRT'							=	'IRT score'  /* 'PSYCH6_IRT'	=	'19+'*/
		'PSYCH6_IRT_r'							=	'PSYCH6-IRTr' /*'PSYCH6_IRT_r'	=	'19+'*/
		'Fatigue6Final_theta_13'				=	'<13'
		'Fatigue6Final_theta_13_r'			=	'<13'
		'Fatigue6Final_theta_13_15'		=	'13-15'
		'Fatigue6Final_theta_13_15_r'	=	'13-15'
		'Fatigue6Final_theta_15_17'		=	'15-17'
		'Fatigue6Final_theta_15_17_r'	=	'15-17'
		'Fatigue6Final_theta_17'				=	'17-19'
		'Fatigue6Final_theta_17_r'			=	'17-19'
		'SOMA6'										=	'summed score'
		'SOMA6_r'									=	'summed score'
		'SOMA6_IRT'								=	'IRT score' /*'SOMA6_IRT'	=	'19+'*/
		'SOMA6_IRT_r'							=	'SOMA6-IRTr' /* 'SOMA6_IRT_r'	=	'19+'*/
		'IRT_affectDisorders'					=	'AD-IRT'
		'IRT_affectDisorders_r'				=	'AD-IRT'
		'IRT_subsUseDisorder'				=	'SU-IRT'
		'IRT_subsUseDisorder_r'			=	'SU-IRT'
		'IRT_substanceUse'						=	'SU-IRT'
		'IRT_substanceUse_r'					=	'SU-IRT'
			;

	value $var_P6r_S6r_AFFrSUDr
/*continuous variables*/
		'AnxDep6Final_theta_13_r'			=	'PSYCH6-IRTr age <13' 
		'AnxDep6Final_theta_13_15_r'	=	'PSYCH6-IRTr age 13-15'
		'AnxDep6Final_theta_15_17_r'	=	'PSYCH6-IRTr age 15-17'
		'AnxDep6Final_theta_17_r'			=	'PSYCH6-IRTr age 17-19'
		'PSYCH6_IRT_r'							=	'PSYCH6r' /*'PSYCH6_IRT_r'	=	'PSYCH6-IRTr age 19+'*/
		'Fatigue6Final_theta_13_r'			=	'SOMA6-IRTr age <13'
		'Fatigue6Final_theta_13_15_r'	=	'SOMA6-IRTr age 13-15'
		'Fatigue6Final_theta_15_17_r'	=	'SOMA6-IRTr age 15-17'
		'Fatigue6Final_theta_17_r'			=	'SOMA6-IRTr age 17-19'
		'SOMA6_IRT_r'							=	'SOMA6r ' /* 'SOMA6_IRT_r'	=	'SOMA6-IRTr age 19+' */
		'IRT_affectDisorders_r'				=	'ADr'
		'IRT_substanceUse_r'					=	'SUr'
			;
	value $PSYCH6_SOMA6_byAgeGp
		'AnxDep6Final_theta_13'				=	'<13'
		'AnxDep6Final_theta_13_r'			=	'<13'
		'AnxDep6Final_theta_13_15'		=	'13-15'
		'AnxDep6Final_theta_13_15_r'	=	'13-15'
		'AnxDep6Final_theta_15_17'		=	'15-17'
		'AnxDep6Final_theta_15_17_r'	=	'15-17'
		'AnxDep6Final_theta_17'				=	'17-19'
		'AnxDep6Final_theta_17_r'			=	'17-19'
		'PSYCH6'										=	'19+'
		'PSYCH6_IRT'								=	'19+'  /* 'PSYCH6_IRT'	=	'19+'*/
		'PSYCH6_IRT_r'							=	'19+' /*'PSYCH6_IRT_r'	=	'19+'*/
		'Fatigue6Final_theta_13'				=	'<13'
		'Fatigue6Final_theta_13_r'			=	'<13'
		'Fatigue6Final_theta_13_15'		=	'13-15'
		'Fatigue6Final_theta_13_15_r'		=	'13-15'
		'Fatigue6Final_theta_15_17'		=	'15-17'
		'Fatigue6Final_theta_15_17_r'		=	'15-17'
		'Fatigue6Final_theta_17'				=	'17-19'
		'Fatigue6Final_theta_17_r'			=	'17-19'
		'SOMA6'										=	'19+'
		'SOMA6_IRT'								=	'19+' /*'SOMA6_IRT'	=	'19+'*/
		'SOMA6_IRT_r'							=	'19+' /* 'SOMA6_IRT_r'	=	'19+'*/
		;
	value $PRSUKBPhenoAbb
		"UKB1558"=	'AIF'
		"UKB3456"=	'CPD'
		"UKB20453"=	'ETC'
		"UKB20455"=	'ALCU'
		"UKB1249"=	'PTS'
		"UKB1498"=	'CI'
		"UKB21001"=	'BMI'
		"UKB50"=		'SH'
		;
	value $PRSUKBPhenoFull
		"UKB1558"=	'alcohol intake frequency'
		"UKB3456"=	'cigarettes per day'
		"UKB20453"=	'ever taken cannabis'
		"UKB20455"=	'age at last cannabis use'
		"UKB1249"=	'past tobacco smoking'
		"UKB1498"=	'coffee intake'
		"UKB21001"=	'BMI'
		"UKB50"=		'standing height'
		;
	value $ZYGOSITY_abbr
		'1'='MZFF' 
		'2'='MZMM' 
		'3'='DZFF'
		'4'='DZMM'
		'5'='DZFM' 
		'6'='DZMF'		
		'9'='Unknown'
		;
	 value $zygo5Groups
		'1'=	'MZFF' 
		'2'=	'MZMM' 
		'3'=	'DZFF'
		'4'=	'DZMM'
		'5'=	'DZO' 
		;
	 value $zygo5GroupsFull
		'1'=	'Monozygotic females' 
		'2'=	'Monozygotic males' 
		'3'=	'Dizygotic females'
		'4'=	'Dizygotic males'
		'5'=	'Dizygotic opposite sexes' 
		;
	 value $ZYGOSITY_full
		'1'='MZ female' 
		'2'='MZ male' 
		'3'='DZ female'
		'4'='DZ male'
		'5'='DZ twins where the female was born first' 
		'6'='DZ twins where the male was born first' 		
		'9'='Zygosity not known or unsure'
		;		
	value $pValThresholdsS1toS8_
		'S1'='p < 5e-08'
		'S2'='p < 1e-05'
		'S3'='p < 1e-03'
		'S4'='p < 0.01'
		'S5'='p < 0.05'
		'S6'='p < 0.1'
		'S7'='p < 0.5'
		'S8'='p < 1'
		;
	 value $sexGroups3_
	 	'allSexes'= 'F+M'
		'females'='F'
		'males'='M'
	 	;
run;
/*-------------------------------This is the end of this program-----------------------------------------------*/
