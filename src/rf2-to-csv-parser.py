#Quick script for converting SNOMED CT snapshot files from the RF2 format to a .csv that can be loaded into Neo4j

#Imports
import re


#Paths of required SNOMED CT RF2 snapshot files
PATH_DESCRIPTIONS = r"data\snomed-snapshot\sct2_Description_Snapshot-en_INT_20231201.txt"
PATH_RELATIONSHIPS = r"data\snomed-snapshot\sct2_Relationship_Snapshot_INT_20231201.txt"
PATH_CONCEPTS = r"data\snomed-snapshot\sct2_Concept_Snapshot_INT_20231201.txt"
#Path to save to
SAVE_PATH = "output"



#Parse Descriptions file
with open(PATH_DESCRIPTIONS, encoding="utf8") as file:
     text = file.read()
split_text = text.split("\n")

#Wrap 7th column (text descriptions) in quotes
for idx, line in enumerate(split_text[1:-1], 1):
    split_line = line.split("\t")
    split_line[7] = '"' + re.sub("\"", "'", split_line[7]) + '"'       
    split_text[idx] = "\t".join(split_line)
parsed = re.sub("\t", ",", "\n".join(split_text))

#Save parsed Descriptions file as csv
with open(f"{SAVE_PATH}/descriptions-snomed-2023.csv", "w", encoding="utf8") as file:
     file.write(parsed)



#Parse Relationships file
with open(PATH_RELATIONSHIPS, encoding="utf8") as file:
     text = file.read()
split_text = text.split("\n")
parsed = re.sub("\t", ",", "\n".join(split_text))

#Save parsed Relationships file as csv
with open(f"{SAVE_PATH}/relationships-snomed-2023.csv", "w", encoding="utf8") as file:
     file.write(parsed)



#Parse Concepts file
with open(PATH_CONCEPTS, encoding="utf8") as file:
     text = file.read()
split_text = text.split("\n")
parsed = re.sub("\t", ",", "\n".join(split_text))

#Save parsed Concepts file as csv
with open(f"{SAVE_PATH}/concepts-snomed-2023.csv", "w", encoding="utf8") as file:
     file.write(parsed)

