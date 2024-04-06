//Find descendants of metastatic neoplasm morphology
MATCH (meta:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id:$meta_id})
//Find clinical findings met meta
OPTIONAL MATCH (meta_finding:ClinicalFinding)-[:ASSOCIATED_MORPHOLOGY]->(meta)
WITH collect(meta_finding)+collect(meta) AS results_list
UNWIND results_list AS results
RETURN DISTINCT results;