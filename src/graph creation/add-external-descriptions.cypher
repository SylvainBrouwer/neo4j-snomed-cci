:auto LOAD CSV WITH HEADERS FROM 'file:///snomed-descriptions-dutch.csv' AS row
CALL {
	WITH row
	MATCH (c:Concept {id: toInteger(row.Code)})
	SET
	c.descriptions_nl = coalesce(c.descriptions_nl, []) + row.Omschrijving
} IN TRANSACTIONS OF 10000 ROWS;

:auto LOAD CSV WITH HEADERS FROM 'file:///umls-descriptions-dutch.csv' as row
CALL {
	WITH row
	MATCH (c:Concept {id: toInteger(row.SNOMEDID)})
	SET
	c.descriptions_umls = coalesce(c.descriptions_umls, []) + row.DESCRIPTION

} IN TRANSACTIONS OF 10000 ROWS;