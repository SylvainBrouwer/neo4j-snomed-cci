//Retrieve all descendants of diabetes
MATCH (diabetes:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $diabetes_id})
RETURN DISTINCT diabetes AS results