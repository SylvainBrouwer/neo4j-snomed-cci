//This should really be incorperated into loading in descriptions
MATCH (c:Concept)
SET c.descriptions = [x IN c.descriptions | toLower(x)]
SET c.descriptions_nl = [x IN c.descriptions_nl | toLower(x)]
SET c.descriptions_umls = [x IN c.descriptions_umls | toLower(x)]
RETURN c