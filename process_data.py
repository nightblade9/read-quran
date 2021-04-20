# Python 3
import json

INPUT_FILE = "ayahobject.json"
OUTPUT_FILE = "output.json"

json_data = [] # array of docs

with open(INPUT_FILE, 'r', encoding='utf8') as f:
    json_data = json.loads(f.read())

# 114 surahs, each is a list of ayahs
output = []
for i in range(114):
    output.append([])

for entry in json_data:
    if entry != {}: # dunno why first item is this
        surah_number = int(entry["surah"]["number"])
        ayah_number = int(entry["numberInSurah"])
        arabic = entry["uthmaniText"]
        page_number = int(entry["page"])
        
        doc = {
            "ayah_number": ayah_number,
            "page_number": page_number,
            "arabic": arabic
        }

        # -1: array is base 0, surah is base 1
        output[surah_number - 1].append(doc)

output_text = json.dumps(output, ensure_ascii=False)

with open(OUTPUT_FILE, 'w', encoding='utf8') as f:
    f.write(output_text)

print("Done.")