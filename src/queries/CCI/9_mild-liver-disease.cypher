//Find all descendants of liver failure
MATCH (hepfail:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $hepfail_id})
WITH collect(hepfail) AS hepfail
//Find all descendants of liver cancer
MATCH (lcancer:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $lcancer_id})
WITH hepfail, collect(lcancer) AS lcancer
//Merge as exclusions
WITH hepfail + lcancer AS exclusions
//Find all descendants of kidney disease
MATCH (ldisease:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $ldisease_id})
WITH exclusions, collect(ldisease) AS ldisease
//Find all descendants of abnormal liver function
MATCH (abnormallfunc:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $abnormallfunc_id})
WITH exclusions, ldisease, collect(abnormallfunc) AS abnormallfunc
//Find all descendants of hepatic encephalopathy
MATCH (hepenceph:ClinicalFinding)-[:IS_A*0..]->(:ClinicalFinding {id: $hepenceph_id})
WITH exclusions, ldisease, abnormallfunc, collect(hepenceph) AS hepenceph
//Find cholangitis
MATCH (cholangitis:ClinicalFinding {id: $cholangitis_id})
WITH exclusions, ldisease, abnormallfunc, hepenceph, collect(cholangitis) AS cholangitis
//Merge findings
WITH exclusions, ldisease + abnormallfunc + hepenceph + cholangitis AS findings
//Filter out exclusions
WITH [finding IN findings WHERE NOT finding IN exclusions] AS results_list
UNWIND results_list AS results
RETURN DISTINCT results
