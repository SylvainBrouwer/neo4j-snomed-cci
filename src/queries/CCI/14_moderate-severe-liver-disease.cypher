//Find descendants of hepatic failure
MATCH (hepfail:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $hepfail_id})
WITH collect(hepfail) AS hepfail
//Find descendants of relevant varices
MATCH (varices:ClinicalFinding)-[:IS_A*0..]->(varices_root:ClinicalFinding)
WHERE varices_root.id in $varices_ids
WITH hepfail, collect(varices) AS varices
//Find descendants of portal hypertension
MATCH (porht:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id:$porht_id})
WITH hepfail, varices, collect(porht) AS porht
//Merge results
WITH hepfail + varices + porht AS results_list
UNWIND results_list AS results
RETURN DISTINCT results