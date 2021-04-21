extends Node2D

const PAGES_DATA = "res://data/pages.json"

var _page:Array = [] # Page data, list of ayaat

func _ready():
	var arabic = ""
	for ayah in _page:
		arabic += ayah["arabic"] + "?"
	$ALabel.arabic_input = arabic

# Called before ready
func setup_surah(surah_number:int) -> void:
	var json_data = _parse_data()
	
	for page_number in range(len(json_data)):
		var page = json_data[page_number]
		for ayah in page:
			if ayah["surah_number"] == surah_number:
				print("It's page %s" % page_number)
				_page = page
	
	# TODO: collect all pages' ayaat for this surah

# Called before ready
func setup_page(page_number:int) -> void:
	var json_data = _parse_data()
	_page = json_data[page_number]

func _parse_data():
	# TODO: singleton I guess
	var f = File.new()
	f.open(PAGES_DATA, File.READ)
	var pages_data = f.get_as_text()
	var json_data = JSON.parse(pages_data).result # TODO: error checking?
	f.close()
	return json_data
