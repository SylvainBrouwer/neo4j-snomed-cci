:auto LOAD CSV WITH HEADERS FROM 'file:///descriptions-snomed-2023.csv' AS row
CALL {
	WITH row
	WITH toBoolean(toInteger(row.active)) AS active, row AS row
	WHERE active
	MATCH (c:Concept {id: toInteger(row.conceptId)})
	SET
	c.descriptions = coalesce(c.descriptions, []) + row.term
} IN TRANSACTIONS OF 10000 ROWS;