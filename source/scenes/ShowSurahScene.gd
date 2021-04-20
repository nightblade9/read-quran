extends Node2D

var PAGES_DATA = "res://data/pages.json"

# Called before ready
func setup(page_number:int) -> void:
	var f = File.new()
	f.open(PAGES_DATA, File.READ)
	var pages_data = f.get_as_text()
	var json_data = JSON.parse(pages_data).result # TODO: error checking?
	f.close()
	
	for surah_number in range(len(json_data)):
		var surah = json_data[surah_number]
		for ayah in surah:
			if ayah["page_number"] == page_number:
				print("Gotcha: surah %s, ayah %s" % [surah_number, ayah["ayah_number"]])
				break # inner break only. TODO: return instead, first value is correct
