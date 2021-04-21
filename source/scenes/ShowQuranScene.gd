extends Node2D

const PAGES_DATA = "res://data/pages.json"
var _page:Array # Page JSON data: array of ayaat

onready var _alabel = $ALabel

# Called before ready
func setup_surah(surah_number:int) -> void:
	var json_data = _parse_data()
	
	for page_number in range(len(json_data)):
		var page = json_data[page_number]
		for ayah in page:
			if ayah["surah_number"] == surah_number:
				print("It's page %s" % page_number)
				_page = page
	
	# NOW: collect all pages' ayaat for this surah

# Called before ready
func setup_page(page_number:int) -> void:
	var json_data = _parse_data()
	_page = json_data[page_number]

func _ready():
	# TODO: un-hardcode when you fix scene changes
	_page = _parse_data()[165]
	
	var text = ""
	for ayah in _page:
		text = "%s\n%s\n%s" % [text, ayah["arabic"], ayah["ayah_number"]]
	
	$ALabel.arabic_input = text

func _parse_data():
	# TODO: singleton I guess
	var f = File.new()
	f.open(PAGES_DATA, File.READ)
	var pages_data = f.get_as_text()
	var json_data = JSON.parse(pages_data).result # TODO: error checking?
	f.close()
	return json_data
