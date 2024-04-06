//Find all descendants of skin BodyStructure
MATCH (skin:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id: $skin_id})
//Find all cancers with the skin as finding site
MATCH (skin)<-[:FINDING_SITE]-(skin_cancer:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $cancer_id})
WITH collect(DISTINCT skin_cancer) AS skin_cancer
//Find all descendents of the metastatic neoplasm morphology
MATCH (meta:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id:$meta_id})
//Find all metastatic cancers
MATCH (meta)<-[:ASSOCIATED_MORPHOLOGY]-(meta_cancer:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $cancer_id})
WITH skin_cancer, collect(DISTINCT meta_cancer) AS meta_cancer
//Find all cancers
MATCH (cancer:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $cancer_id})
WITH collect(DISTINCT cancer) AS cancer, skin_cancer, meta_cancer
//Exclude skin cancers and metastatic cancers from results
WITH [c IN cancer WHERE NOT c IN skin_cancer] AS non_skin_cancer, meta_cancer
WITH [c IN non_skin_cancer WHERE NOT c IN meta_cancer] AS results_list
UNWIND results_list AS results
RETURN results