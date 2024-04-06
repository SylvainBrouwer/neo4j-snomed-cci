:auto MATCH (n)
CALL {
    WITH n
    DETACH DELETE n
} IN TRANSACTIONS OF 10000 ROWS;

DROP CONSTRAINT Concept_id IF EXISTS;

CREATE CONSTRAINT Concept_id IF NOT EXISTS
FOR (c:Concept)
REQUIRE c.id IS UNIQUE;

:auto LOAD CSV WITH HEADERS FROM 'file:///concepts-snomed-2023.csv' AS row
CALL {
	WITH row
	WITH toBoolean(toInteger(row.active)) AS active, row as row
	WHERE active
	MERGE (c:Concept {id: toInteger(row.id)})
} IN TRANSACTIONS OF 10000 ROWS;