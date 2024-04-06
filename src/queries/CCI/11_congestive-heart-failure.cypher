//Find descendants of congestive heart failure
MATCH (hf:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $hf_id})
WITH collect(hf) AS hf
//Find descendants of coronary artery structure
MATCH(corart:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id: $corart_id})
//Find procedures with coronary artery as a procedure site
MATCH (pro:Procedure)-[:IS_A*0..]->(:Procedure)-[:PROCEDURE_SITE_DIRECT]->(corart)
//Filter on surgical repairs
WHERE (pro)-[:METHOD]->()-[:IS_A*0..]->(:QualifierValue {id: $repair_id})
WITH hf, collect(pro) AS pro
//Merge results
WITH hf + pro AS results_list
UNWIND results_list AS results
RETURN DISTINCT results