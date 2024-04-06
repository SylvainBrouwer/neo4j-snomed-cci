//Find all descendants of diabetes
MATCH (diabetes:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $diabetes_id})
//Find all clinical findings caused by diabetes
MATCH (complications:ClinicalFinding)-[:DUE_TO]->(diabetes)
//Return complications
RETURN DISTINCT complications AS results