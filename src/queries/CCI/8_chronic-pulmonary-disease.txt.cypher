//Retrieve all descendants of mentioned ClinicalFindings
MATCH (cdr:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $cdrespiratory_id})
WITH collect(cdr) AS cdr
MATCH (eld:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $envlungd_id})
WITH cdr, collect(eld) AS eld
MATCH (pemb:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $pulmemb_id})
WITH cdr, eld, collect(pemb) AS pemb
MATCH (asthma:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $asthma_id})
WITH cdr, eld, pemb, collect(asthma) AS asthma
//Merge findings
WITH cdr + eld + pemb + asthma AS results_list
UNWIND results_list AS results
RETURN DISTINCT results