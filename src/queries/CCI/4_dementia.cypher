//Retrieve all descendants of dementia
MATCH (descendants:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id:$dementia_id})
RETURN DISTINCT descendants AS results;