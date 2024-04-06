MATCH (c1:Concept {id: $id1})
MATCH (c2:Concept {id: $id2})
MATCH path = (c1)-[:IS_A*]->(an)<-[:IS_A*]-(c2)
RETURN path, an ORDER BY length(path) LIMIT 1