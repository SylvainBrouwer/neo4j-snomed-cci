//Find all descendents of HIV
MATCH (hiv_descendants:Organism)-[:IS_A*0..]->(:Organism {id:$hiv_id})
//Find all ClinicalFinding caused by HIV
OPTIONAL MATCH (findings:ClinicalFinding)-[:CAUSATIVE_AGENT]->(hiv_descendants)
//Merge results
WITH collect(hiv_descendants) + collect(findings) AS results_list
UNWIND results_list AS results
RETURN DISTINCT results;