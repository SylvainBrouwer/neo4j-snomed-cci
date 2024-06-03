//Find autoimmune conditions in connective tissue
MATCH (:BodyStructure {id: $ctissue_id})<-[:FINDING_SITE]-(auto:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $auto_id})
WITH collect(auto) as auto
//Find all conditions occurring due to lupus
MATCH (due_lupus:ClinicalFinding)-[:DUE_TO]->(:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $lupus_id})
WITH auto, collect(due_lupus) AS due_lupus
//Find descendants of arthritis
MATCH (arthritis:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $arthritis_id})
WITH auto, due_lupus, collect(arthritis) AS arthritis
//Find descendants of arteriitis temporalis
MATCH (arttemp:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $arttemp_id})
WITH auto, due_lupus, arthritis, collect(arttemp) as arttemp
//Find descendants of extra articular rheumatoid processes
MATCH (earp:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $earp_id})
WITH auto, due_lupus, arthritis, arttemp, collect(earp) AS earp
//Find all relevant myositis
MATCH (myo:ClinicalFinding)-[:IS_A*0..]->(myo_root:ClinicalFinding)
WHERE myo_root.id in $myo_ids
WITH auto, due_lupus, arthritis, arttemp, earp, collect(myo) AS myo
//Find descendants of Polymyalgia rheumatica
MATCH (polymy:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $polymy_id})
WITH auto, due_lupus, arthritis, arttemp, earp, myo, collect(polymy) AS polymy
//Find descendants of overlap syndrome
MATCH (overlap:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $overlap_id})
WITH auto, due_lupus, arthritis, arttemp, earp, myo, polymy, collect(overlap) AS overlap
//Merge results
WITH auto + due_lupus + arthritis + arttemp + earp + myo + polymy + overlap AS res_list
UNWIND res_list AS results
RETURN DISTINCT results