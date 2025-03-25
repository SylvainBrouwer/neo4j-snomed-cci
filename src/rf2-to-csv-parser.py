# Quick script for converting SNOMED CT snapshot files from the RF2 format to a .csv that can be loaded into Neo4j

# Imports
import os
import re


# Get Paths for data files
DATA_DIR = "data/snomed-snapshot"
PATH_DESCRIPTIONS = None
PATH_RELATIONSHIPS = None
PATH_CONCEPTS = None
for filename in os.listdir(DATA_DIR):
    if re.match(r"sct2_Concept_Snapshot", filename):
        PATH_CONCEPTS = os.path.join(DATA_DIR, filename)
    if re.match(r"sct2_Description_Snapshot", filename):
        PATH_DESCRIPTIONS = os.path.join(DATA_DIR, filename)
    if re.match(r"sct2_Relationship_Snapshot", filename):
        PATH_RELATIONSHIPS = os.path.join(DATA_DIR, filename)

assert PATH_RELATIONSHIPS, "No Relationships file found!"
assert PATH_CONCEPTS, "No Concepts file found!"
assert PATH_DESCRIPTIONS, "No Descriptions file found!"


# Path to save to
SAVE_PATH = "output"
if not os.path.exists(SAVE_PATH):
    os.mkdir(SAVE_PATH)


# Parse Descriptions file
with open(PATH_DESCRIPTIONS, encoding="utf8") as file:
    text = file.read()
split_text = text.split("\n")

# Wrap 7th column (text descriptions) in quotes
for idx, line in enumerate(split_text[1:-1], 1):
    split_line = line.split("\t")
    split_line[7] = '"' + re.sub("\"", "'", split_line[7]) + '"'       
    split_text[idx] = "\t".join(split_line)
parsed = re.sub("\t", ",", "\n".join(split_text))

# Save parsed Descriptions file as csv
with open(f"{SAVE_PATH}/descriptions-snomed-2023.csv", "w", encoding="utf8") as file:
    file.write(parsed)



# Parse Relationships file
with open(PATH_RELATIONSHIPS, encoding="utf8") as file:
    Stext = file.read()
split_text = text.split("\n")
parsed = re.sub("\t", ",", "\n".join(split_text))

# Save parsed Relationships file as csv
with open(f"{SAVE_PATH}/relationships-snomed-2023.csv", "w", encoding="utf8") as file:
    file.write(parsed)



# Parse Concepts file
with open(PATH_CONCEPTS, encoding="utf8") as file:
    text = file.read()
split_text = text.split("\n")
parsed = re.sub("\t", ",", "\n".join(split_text))

# Save parsed Concepts file as csv
with open(f"{SAVE_PATH}/concepts-snomed-2023.csv", "w", encoding="utf8") as file:
    file.write(parsed)

