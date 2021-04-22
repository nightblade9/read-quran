extends Control

const ALabel = preload("res://addons/arabic-text/ALabel.gd")

const _PAGES_DATA = "res://data/pages.json"
const _SURAH_DATA = "res://data/surahs.json"
onready var _template = $Template
onready var _ayaat_container = $ScrollContainer/VBoxContainer

var _page:Array = [] # Page data, list of ayaat
var _surah_names:Array = []

func _ready():
	_parse_surah_names()
	
	remove_child(_template)
	_template.visible = false
	
	for ayah in _page:
		var ayah_number = ayah["ayah_number"]
		if ayah_number == 1:
			# Push surah name
			var surah_data = _surah_names[ayah["surah_number"] - 1] # base 1 to base 0
			var surah_name = surah_data["titleAr"]
			var hbox = _create_entry(0, surah_name)
			_ayaat_container.add_child(hbox)
			
		var hbox = _create_entry(ayah_number, ayah["arabic"])
		_ayaat_container.add_child(hbox)
		#break # uncommment this to see jankiness
		
	_template.queue_free()
	_ayaat_container.remove_child(_ayaat_container.get_child(0))

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
	
func _create_entry(ayah_number:int, arabic_text:String) -> HBoxContainer:
	var hbox = _template.duplicate()
	hbox.visible = true
	
	var number_label =  hbox.get_node("TemplateHBox/NumberLabel")
	if ayah_number > 0: # ayah
		number_label.text = "(%s)" % ayah_number
	else:
		number_label.queue_free() # surah heading
		
	var arabic_label = _template.get_node("TemplateHBox/ArabicLabel")
	arabic_label.arabic_input = arabic_text
	
	print("box %s: %s" % [ayah_number, arabic_text])
	return hbox

func _parse_surah_names():
	# TODO: singleton I guess
	var f = File.new()
	f.open(_SURAH_DATA, File.READ)
	var surah_data = f.get_as_text()
	var json_data = JSON.parse(surah_data).result # TODO: error checking?
	f.close()
	_surah_names = json_data

func _parse_data():
	# TODO: singleton I guess
	var f = File.new()
	f.open(_PAGES_DATA, File.READ)
	var pages_data = f.get_as_text()
	var json_data = JSON.parse(pages_data).result # TODO: error checking?
	f.close()
	return json_data
