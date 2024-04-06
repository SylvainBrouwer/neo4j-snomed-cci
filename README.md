# Requirements
In order to create a graph for SNOMED CT you require the Concepts, Descriptions and Relationships files from a SNOMED CT snapshot. These can be freely obtained on a personal licence from the [National Library of Medicine](https://www.nlm.nih.gov/healthit/snomedct/index.html), as long as you're in a SNOMED CT member territory.

# Graph Creation

**1.** SNOMED CT files are distributed in the RF2 release format, these are incompatible with loading in CYPHER, use the provided python script to convert to .csv.

**2.** Place all .csv files into the "Import" folder of your Neo4j instance.

**3.** Run `create-concepts.cypher` to create all concepts nodes.

**4.** Run `create-relations.cypher` to create all relationships. Note that this step may be taxing on memory. Depending on your system you may want to create relationships in batches.

**5.** Run `set-descriptions.cypher` to set descriptions for all nodes.

**6.** Run `set-labels.cypher` to label nodes according to their SNOMED CT hierarchy. Note that this step may take quite a while (>1h).

**7. (Optional):** Run `descriptions-to-lower.cypher` to set all descriptions to lowercase

# Queries

Note that the provided queries are not an exact match for the Charlson Comorbidity Index, several CCI categories were broadened somewhat, and procedures are included where thought to be relevant. For a "pure" SNOMED CT code list for the CCI see the work by [Fortin et al](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9541054/), which I referenced while creating queries.

Equivalent SNOMED CT Expression Constraint Language queries are provided in `ECL.txt`, results for the CYPHER queries were verified against results for the ECL queries in the [IHTSDO browser](https://browser.ihtsdotools.org/?).

**Note**: Run `params.cypher` to initialize all parameters referenced in the query files.