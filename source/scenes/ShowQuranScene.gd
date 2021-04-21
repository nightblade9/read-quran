extends Node2D

const ALabel = preload("res://addons/arabic-text/ALabel.gd")

const _PAGES_DATA = "res://data/pages.json"
onready var _template_label = $TemplateLabel
onready var _ayaat_container = $VBoxContainer

var _page:Array = [] # Page data, list of ayaat

func _ready():
	for ayah in _page:
		
		var hbox = HBoxContainer.new()
		
		var label = Label.new()
		label.text = "(%s)" % ayah["ayah_number"]
		hbox.add_child(label)
		
		var alabel = _template_label.duplicate()
		alabel.visible = true
		alabel.arabic_input = ayah["arabic"]
		hbox.add_child(alabel)
		
		_ayaat_container.add_child(hbox)

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
	f.open(_PAGES_DATA, File.READ)
	var pages_data = f.get_as_text()
	var json_data = JSON.parse(pages_data).result # TODO: error checking?
	f.close()
	return json_data
