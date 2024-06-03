//Part 1: Clinical Findings
//First we identify morphologies for which associated clinical findings should not be included
//Find all descendants of morphologic abnormality varix
MATCH (varix:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id: $varix_id})
WITH collect(varix) AS varix
//Find morphologic abnormality bleeding
MATCH (hemorrhage:BodyStructure {id: $hemorrhage_id})
WITH varix, collect(hemorrhage) AS hemorrhage
//Find all ClinicalFindings with ASSOCIATED_MORPHOLOGY of varix or hemorrhage
WITH varix + hemorrhage AS m
UNWIND m AS morphology_exclude
MATCH (excluded_by_morphology:ClinicalFinding)-[:ASSOCIATED_MORPHOLOGY]->(morphology_exclude)
WITH collect(excluded_by_morphology) AS excluded_by_morphology
//Now we identify body structures which we do not want to include as a finding site
//Find all descendants of BodyStructure carotis
MATCH (carotis:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id: $carotis_id})
WITH excluded_by_morphology, collect(DISTINCT carotis) AS carotis
//Find all descendants of BodyStructure vascular structure of head and/or neck
MATCH (vasc_headneck:BodyStructure)-[:IS_A*0..]->(BodyStructure {id: $vasc_headneck_id})
WITH excluded_by_morphology, carotis, collect(DISTINCT vasc_headneck) AS vasc_headneck
//Find Bodystructure aortic structure
MATCH (aorta:BodyStructure {id: $aorta_id})
WITH excluded_by_morphology, carotis, vasc_headneck, collect(aorta) AS aorta
//Find all descendants of Bodystructure Structure of blood vessel of thoracic cross-sectional segment of trunk
MATCH (vasc_thorax:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id: $vasc_thorax_id})
WITH excluded_by_morphology, carotis, vasc_headneck, aorta, collect(vasc_thorax) AS vasc_thorax
//Find ClinicalFindings with FINDING_SITE of carotis, headneck or aorta
WITH excluded_by_morphology, carotis + vasc_headneck + aorta + vasc_thorax AS nonperipheral
UNWIND nonperipheral AS findingsite_exclude
MATCH (excluded_by_findingsite:ClinicalFinding)-[:FINDING_SITE]->(findingsite_exclude)
WITH excluded_by_morphology, nonperipheral, collect(excluded_by_findingsite) AS excluded_by_findingsite
//Find all descendants of ClinicalFinding vacular disorder
WITH nonperipheral, excluded_by_morphology + excluded_by_findingsite AS exclusions
MATCH (vasc_disorder:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $vasc_disorder_id})
WITH nonperipheral, exclusions, collect(vasc_disorder) AS vasc_disorder
//Remove exclusions from vascular disorders
WITH nonperipheral, [disorder IN vasc_disorder WHERE NOT disorder IN exclusions] AS vasc_disorder_filtered
//Find all descendants of ClinicalFinding claudication intermittens
MATCH (claudicatio:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $claudicatio_id})
WITH nonperipheral, vasc_disorder_filtered, collect(claudicatio) AS claudicatio
//Merge relevant ClinicalFindings
WITH nonperipheral, vasc_disorder_filtered + claudicatio AS findings_results
//Part 2: Procedures
//We now identify peripheral vascular sites for which we want relevant procedures
//Find all descendants of BodyStructure regional blood vessels
MATCH (rbv:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id:$rbv_id})
WITH nonperipheral, findings_results, collect(DISTINCT rbv) AS rbv
//Find all descendant of BodyStructure peripheral vascular system
MATCH (peripheral_vasc:BodyStructure)-[:IS_A*0..]->(:BodyStructure {id:$peripheral_vasc_id})
WITH nonperipheral, findings_results, rbv, collect(DISTINCT peripheral_vasc) AS peripheral_vasc
WITH nonperipheral, findings_results, rbv + peripheral_vasc AS nonthorax_vasc
//Remove nonperipheral body structures from results -> filter 1
WITH nonperipheral, findings_results, [bs IN nonthorax_vasc WHERE NOT bs IN nonperipheral] AS noncentral_vasc
UNWIND noncentral_vasc AS match_struct
//Find all repair Procedures with a peripheral vascular site
MATCH (repairs:Procedure)-[:PROCEDURE_SITE_DIRECT]->(match_struct)
WHERE (repairs)-[:METHOD]->()-[:IS_A*0..]->(:QualifierValue {id: $repair_id}) //Check
WITH nonperipheral, findings_results, collect(DISTINCT repairs) AS repairs
UNWIND nonperipheral AS nonmatch_struct
//Match Procedures with a nonperipheral site
MATCH (repairs_nonperipheral:Procedure)-[:PROCEDURE_SITE_DIRECT]->(nonmatch_struct)
WITH findings_results, repairs, collect(DISTINCT repairs_nonperipheral) AS repairs_nonperipheral
//Extra filter for nonperipheral procedures -> filter 2
WITH findings_results, [p IN repairs WHERE NOT p in repairs_nonperipheral] AS repairs_filtered
//Find pta
MATCH (pta:Procedure {id: $pta_id})
WITH findings_results, repairs_filtered, collect(pta) AS pta
WITH findings_results, repairs_filtered + pta AS procedures_results
WITH findings_results + procedures_results AS res_list
// LIMITER
UNWIND res_list AS results
RETURN DISTINCT results