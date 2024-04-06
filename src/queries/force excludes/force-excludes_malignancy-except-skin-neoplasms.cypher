MATCH (fe_cancer: ClinicalFinding)
WHERE fe_cancer.id = $pcc_id OR fe_cancer.id = $bcc_id
RETURN fe_cancer