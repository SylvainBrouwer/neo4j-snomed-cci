//Find cascade stomach
MATCH (cascade: ClinicalFinding {id:$cascade_id})
WITH collect(cascade) AS cascade
//Find all descendants of peptic ulcer
MATCH (peptic:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $peptic_id})
WITH cascade, collect(peptic) AS peptic
//Merge results
WITH cascade + peptic AS results_list
UNWIND results_list AS results
RETURN DISTINCT results