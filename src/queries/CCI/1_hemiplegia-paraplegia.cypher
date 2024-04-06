//Unwind the list of site ids
UNWIND $hemi_site_exclude as site_exclude
//Find all paralytic syndromes with one of the sites as finding site
MATCH (:ClinicalFinding {id: $para_id})<-[:IS_A*0..]-(site_para:ClinicalFinding)-[:FINDING_SITE]->(:BodyStructure)-[:IS_A*0..]->(site:BodyStructure)
WHERE site.id = site_exclude
WITH collect(site_para) AS site_para
//Find all paralytic syndromes that occur during delivery
MATCH (:ClinicalFinding {id: $para_id})<-[:IS_A*0..]-(del_para:ClinicalFinding)-[:DURING]->(:Procedure)-[:IS_A*0..]->(:Procedure {id:$delivery_id})
WITH site_para, collect(del_para) AS del_para
//Find all paralytic syndromes that occur neonatally
MATCH (:ClinicalFinding {id: $para_id})<-[:IS_A*0..]-(neo_para:ClinicalFinding)-[:OCCURRENCE]->(:QualifierValue)-[:IS_A*0..]->(:QualifierValue {id: $neonatal_id})
WITH site_para, del_para, collect(neo_para) AS neo_para
//Merge into exclude
WITH site_para + del_para + neo_para AS exclude
//Find all paralytic syndromes
MATCH (para:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $para_id})
WITH exclude, collect(para) AS para
//Filter out the exclusions
WITH [p IN para WHERE NOT p IN exclude] AS filtered_para
//Find all descendants of paralysis due to spinal cord lesions
MATCH (paraspinal:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $paraspinal_id})
WITH filtered_para, collect(paraspinal) AS paraspinal
//Find all descendants of cauda equina syndrome
MATCH (cauda:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $cauda_id})
WITH filtered_para, paraspinal, collect(cauda) AS cauda
//Merge results
WITH filtered_para + paraspinal + cauda AS results_list
UNWIND results_list AS results
RETURN DISTINCT results