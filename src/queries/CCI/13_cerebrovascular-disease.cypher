//Find descendants of cerebrovascular disease
MATCH (cvd:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $cvd_id})
//Find clinical findings occurring after descendants of cerebrovascular disuese
OPTIONAL MATCH (after_cvd:ClinicalFinding)-[:AFTER]->(cvd)
WITH cvd, collect(after_cvd) AS after_cvd
//Find clinical findings occurring due to descendants of cerebrovascular disuese
OPTIONAL MATCH (due_cvd:ClinicalFinding)-[:DUE_TO]->(cvd)
WITH collect(cvd) AS cvd, collect(due_cvd) AS due_cvd, after_cvd
//Find descendants of intercranial hemmorhage
MATCH (hemm:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $hemm_id})
WITH collect(hemm) AS hemm, cvd, due_cvd, after_cvd
//Merge clinical findings
WITH hemm + cvd + due_cvd + after_cvd AS findings
//Find descendants of cea procedure
MATCH (cea:Procedure)-[:IS_A*0..]->(:Procedure {id: $cea_id})
WITH findings, collect(cea) AS cea
//Merge results
WITH findings + cea AS results_list
UNWIND results_list AS results
RETURN DISTINCT results