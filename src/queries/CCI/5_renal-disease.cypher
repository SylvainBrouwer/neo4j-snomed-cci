//Find all descendant of kidney disease
MATCH (kdisease:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $kdisease_id})
WITH kdisease
//Find procedures with kidney disease as a focus (dialysis etc.)
OPTIONAL MATCH (kprocedures:Procedure)-[:HAS_FOCUS]->(kdisease)
WITH collect(kdisease) AS kdisease, collect(kprocedures) AS kprocedures
//Find all descendants of nephrectomy
MATCH (nephrectomy:Procedure)-[:IS_A*0..]->(:Procedure {id: $nephrectomy_id})
WITH kdisease, kprocedures, collect(nephrectomy) AS nephrectomy
//Find all descendants of kindey lesion
MATCH (klesion:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $klesion_id})
WITH kdisease, nephrectomy, kprocedures, collect(klesion) AS klesion
//Filter lesions from findings
WITH nephrectomy, kprocedures, [finding IN kdisease WHERE NOT finding in klesion] AS findings
//Merge results
WITH nephrectomy + kprocedures + findings AS results_list
UNWIND results_list AS results
RETURN DISTINCT results