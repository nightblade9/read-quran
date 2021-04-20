# Python 3
import json

INPUT_FILE = "ayahobject.json"
OUTPUT_FILE = "output.json"

json_data = [] # array of docs

with open(INPUT_FILE, 'r', encoding='utf8') as f:
    json_data = json.loads(f.read())

output = []

for entry in json_data:
    if entry != {}: # dunno why first item is this
        surah_number = entry["surah"]["number"]
        ayah_number = entry["numberInSurah"]
        arabic = entry["uthmaniText"]
        page_number = entry["page"]
        
        doc = {
            "surah_number": surah_number,
            "ayah_number": ayah_number,
            "page_number": page_number,
            "arabic": arabic
        }
        output.append(doc)

output_text = json.dumps(output, ensure_ascii=False)

with open(OUTPUT_FILE, 'w', encoding='utf8') as f:
    f.write(output_text)

print("Done.")