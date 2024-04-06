MATCH (c:Concept {id:138875005})
SET c:Root;

MATCH (h:Concept)-[:IS_A]->(r:Root)
SET h:Hierarchy;

:auto MATCH (c:Concept)-[:IS_A*]->(h:Hierarchy)
WITH c, apoc.text.replace(h.descriptions[0], '\s\(.*\)', '') AS labelname
WITH c, apoc.text.upperCamelCase(labelname) AS labelname
CALL {
    WITH c, labelname
    CALL apoc.create.addLabels(c, [labelname]) 
    YIELD node
    RETURN node
} IN TRANSACTIONS OF 20000 ROWS
RETURN node.id;