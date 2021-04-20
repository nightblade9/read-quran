# Python 3
import json

INPUT_FILE = "ayahobject.json"
OUTPUT_FILE = "output.json"

json_data = [] # array of docs

with open(INPUT_FILE, 'r', encoding='utf8') as f:
    json_data = json.loads(f.read())

# 604 pages, each with a list of ayaat. Page ZERO is empty.
output = [[]]

for entry in json_data:
    if entry != {}: # dunno why first item is this
        surah_number = int(entry["surah"]["number"])
        ayah_number = int(entry["numberInSurah"])
        arabic = entry["uthmaniText"]
        page_number = int(entry["page"])

        if page_number >= len(output):
            output.append([]) # new page
        
        doc = {
            "surah_number": surah_number,
            "ayah_number": ayah_number,
            "arabic": arabic
        }

        output[page_number].append(doc)

output_text = json.dumps(output, ensure_ascii=False)

with open(OUTPUT_FILE, 'w', encoding='utf8') as f:
    f.write(output_text)

print("Done.")