:auto LOAD CSV WITH HEADERS FROM 'file:///relationships-snomed-2023.csv' AS row
CALL {
	WITH row
	WITH toBoolean(toInteger(row.active)) AS active, row AS row
	WHERE active
	MATCH (relc:Concept {id: toInteger(row.typeId)})
	WITH row, apoc.text.replace(relc.descriptions[0], '\s\(.*\)', '') AS relname
	WITH row, apoc.text.toUpperCase(relname) AS relname
	MATCH (source:Concept {id: toInteger(row.sourceId)})
	MATCH (destination:Concept {id: toInteger(row.destinationId)})
	CALL apoc.merge.relationship(source, relname, {}, {}, destination, {})
	YIELD rel
	RETURN rel
} IN TRANSACTIONS OF 10000 ROWS
RETURN rel