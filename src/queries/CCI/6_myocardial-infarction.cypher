//Find descendants of myocardial infarctions
MATCH (mi:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id:$mi_id})
//Find descendants of acute ischemic heart disease
MATCH (aihd:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id:$aihd_id})
//Merge results
WITH collect(mi) + collect(aihd) AS results_list
UNWIND results_list as results
RETURN DISTINCT results;