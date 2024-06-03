//Full param set

//*******************************
//**1: Hemiplegia / paraplegia **
//*******************************
//id of ClinicalFinding - "Paralytic syndrome"
:param para_id => 29426003;
//id of ClinicalFinding - "Paralysis due to lesion of spinal cord"
:param paraspinal_id => 372310001;
//id of ClinicalFinding - "Cauda equina syndrome"
:param cauda_id => 192970008;
//ids of BodyStructure nodes excluded as FINDING_SITE (visual, blatter, cranial nerve)
:param hemi_site_exclude => [49549006, 89837001, 25238003];
//id of QualifierValue - "neonatal"
:param neonatal_id => 255407002;
//id of Procedure - "delivery"
:param delivery_id => 236973005;


//***********************************
//**2: Peripheral vascular disease **
//***********************************
//id of BodyStructure - "Varix"
:param varix_id => 12856003;
//id of BodyStructure - "Hemorrhage"
:param hemorrhage_id => 50960005;
//id of BodyStructure - "Structure of carotid and/or cerebral and/or subclavian artery"
:param carotis_id => 299717005;
//id of BodyStructure - "Vascular structure of head and/or neck"
:param vasc_headneck_id => 281232002;
//id of BodyStructure - "Aortic structure"
:param aorta_id => 15825003;
//id of BodyStructure - "Structure of blood vessel of thoracic cross-sectional segment of trunk"
:param vasc_thorax_id => 846601002;
//id of ClinicalFinding - "Disorder of blood vessel"
:param vasc_disorder_id => 27550009;
//id of ClinicalFinding - "Intermittent claudication"
:param claudicatio_id => 63491006;
//id of BodyStructure - "Regional blood vessel"
:param rbv_id => 306954006;
//id of BodyStructure - "Peripheral vascular system"
:param peripheral_vasc_id => 51833009;
//id of QualifierValue - "Surgical repair"
:param repair_id => 257903006;
//id of Procedure - "Percutaneous transluminal angioplasty"
:param pta_id => 5431005;


//******************************
//**3: Metastatic solid tumor **
//******************************
//id of BodyStructure - "Neoplasm, metastatic"
:param meta_id => 14799000;


//****************
//**4: Dementia **
//****************
//id of ClinicalFinding - "Dementia"
:param dementia_id => 52448006;


//*********************
//**5: Renal disease **
//*********************
//id of ClinicalFinding - "Kidney Disease"
:param kdisease_id => 90708001;
//id of Procedure - "Nephrectomy"
:param nephrectomy_id => 175905003;
//id of ClinicalFinding - "Malignant tumor of kidney"
:param kcancer_id => 363518003;
//id of ClinicalFinding - "Kidney Lesion"
:param klesion_id => 79131000119100;


//*****************************
//**6: Myocardial infarction **
//*****************************
//id of ClinicalFinding - "Myocardial infarction"
:param mi_id => 22298006;
//id of ClinicalFinding - "Acute ischemic heart disease"
:param aihd_id => 413439005;


//*****************************************
//**7: Malignancy, except skin neoplasms **
//*****************************************
//id of ClinicalFinding - "Malignant neoplastic disease"
:param cancer_id => 363346000;
//id of BodyStructure - "Skin structure"
:param skin_id => 39937001;
//id of BodyStructure - "Neoplasm, metastatic"
:param meta_id => 14799000;


//********************************
//**8: Chronic pulmonary disease **
//********************************
//id of ClinicalFinding - "Chronic disease of respiratory system"
:param cdrespiratory_id => 17097001;
//id of ClinicalFinding - "Environmental lung disease"
:param envlungd_id => 24417004;
//id of ClinicalFinding - "Pulmonary embolism"
:param pulmemb_id => 59282003;
//id of ClinicalFinding - "Asthma"
:param asthma_id => 195967001;


//**************************
//**9: Mild liver disease **
//**************************
//id of ClinicalFinding - "Disease of liver"
:param ldisease_id => 235856003;
//id of ClinicalFinding - "Hepatic Failure"
:param hepfail_id => 59927004;
//id of ClinicalFinding - "Malignant neoplasm of liver"
:param lcancer_id => 93870000;
//id of ClinicalFinding - "Hepatic encephalopathy"
:param hepenceph_id => 13920009;
//id of ClinicalFinding - "Abnormal liver function"
:param abnormallfunc_id => 75183008;
//id of ClinicalFinding - "Cholangitis"
:param cholangitis_id => 82403002;


//*******************
//**10: HIV / AIDS **
//*******************
//id of Organism - "Human immunodeficiency virus"
:param hiv_id => 19030005;


//*********************************
//**11: Congestive heart failure **
//*********************************
//id of ClinicalFinding - "Congestive Heart Failure"
:param hf_id: 84114007;
//id of BodyStructure - "Coronary Artery Structure"
:param corart_id: 41801008;
//id of QualifierValue - "Surgical repair"
:param repair_id => 257903006;


//*****************************
//**12: Peptic ulcer disease **
//*****************************
//id ClinicalFinding - "Peptic Ulcer"
:param peptic_id => 13200003;
//id of "ClinicalFinding - "Cascade stomach"
:param cascade_id => 54051005;


//********************************
//**13: Cerebrovascular disease **
//********************************
//id of ClinicalFinding - "Cerebrovascular disease"
:param cvd_id => 62914000;
//id of Procedure - "Carotid endarterectomy"
:param cea_id => 66951008;
//id of ClinicalFinding - "Intercranial hemmorhage"
:param hemm_id => 1386000;


//*****************************************
//**14: Moderate or severe liver disease **
//*****************************************
//id of ClinicalFinding - "Hepatic Failure"
:param hepfail_id => 59927004;
//ids of relevant varices (oesophagal, stomach)
:param varices_ids => [28670008, 91109007];
//id of ClinicalFinding - "Portal Hypertension"
:param porht_id => 34742003;


//*********************************************
//**15: Diabetes, with chronic complications **
//*********************************************
//id of ClinicalFinding - "Diabetes mellitus"
:param diabetes_id => 73211009;


//************************************************
//**16: Diabetes, without chronic complications **
//************************************************
//id of Clinical Finding - "Diabetes mellitus"
:param diabetes_id => 73211009;


//**************************
//**17: Rheumatic disease **
//**************************
//id of ClinicalFinding - "Auto-immune disease"
:param auto_id => 85828009;
//id of BodyStructure - "Connective tissue structure"
:param ctissue_id => 21793004;
//id of ClinicalFinding - "Systemic lupus erythematosus"
:param lupus_id => 55464009;
//id of ClinicalFinding - "Arthritis (disorder)"
:param arthritis_id => 3723001;
//id of ClinicalFinding - "Arteriitis temporalis"
:param arttemp_id => 400130008;
//id of ClinicalFinding - "Extra articular rheumatoid processes"
:param earp_id => 52661003;
//ids of myositis
:param myo_ids => [396230008, 31384009];
//id of ClinicalFinding - "Polymyalgia Rheumatica"
:param polymy_id => 65323003;
//id of ClinicalFinding - "Overlap syndrome"
:param overlap_id => 276657008;

