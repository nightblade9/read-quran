extends Control

const ALabel = preload("res://addons/arabic-text/ALabel.gd")
const AyahHbox = preload("res://scenes/AyahHbox.tscn")

const _PAGES_DATA = "res://data/pages.json"
const _SURAH_DATA = "res://data/surahs.json"

onready var _ayaat_container = $ScrollContainer/VBoxContainer
onready var _previous_button = $PreviousButton
onready var _next_button = $NextButton

var _page:Array = [] # Page data, list of ayaat
var _surah_names:Array = []
var _pages_data:Array = []
var _page_number:int = 0

func _ready():
	_parse_surah_names()
	_show_ayaat()

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
	_page_number = page_number

func _show_ayaat() -> void:
	# Show, duplicate, and re-hide later
	_previous_button.visible = true
	_next_button.visible = true
	
	_previous_button.text = "%s >" % (_page_number - 1)
	_next_button.text = "< %s" % (_page_number + 1)
	
	for child in _ayaat_container.get_children():
		_ayaat_container.remove_child(child)
	
	if _page_number > 1:
		_ayaat_container.add_child(_previous_button.duplicate())
		
	_page = _pages_data[_page_number]
	
	for ayah in _page:
		var ayah_number = ayah["ayah_number"]
		if ayah_number == 1:
			# Push surah name
			var surah_data = _surah_names[ayah["surah_number"] - 1] # base 1 to base 0
			var surah_name = surah_data["titleAr"]
			var hbox = _create_entry(0, surah_name)
			
		var hbox = _create_entry(ayah_number, ayah["arabic"])
	
	if _page_number < len(_pages_data) - 1:
		_ayaat_container.add_child(_next_button.duplicate())
	
	# Hide now that we templated them
	_previous_button.visible = false
	_next_button.visible = false
	
func _create_entry(ayah_number:int, arabic_text:String) -> HBoxContainer:
	var hbox = AyahHbox.instance()
	_ayaat_container.add_child(hbox)	
	
	if ayah_number <= 0: # surah header
		hbox.show_header()
	
	hbox.setup(ayah_number, arabic_text)
	return hbox

func _parse_surah_names():
	# TODO: singleton I guess
	var f = File.new()
	f.open(_SURAH_DATA, File.READ)
	var surah_data = f.get_as_text()
	_surah_names = JSON.parse(surah_data).result # TODO: error checking?
	f.close()

func _parse_data():
	# TODO: singleton I guess
	var f = File.new()
	f.open(_PAGES_DATA, File.READ)
	var pages_data = f.get_as_text()
	_pages_data = JSON.parse(pages_data).result # TODO: error checking?
	f.close()

func _on_PreviousButton_pressed():
	if _page_number > 1:
		_page_number -= 1
	_show_ayaat()

func _on_NextButton_pressed():
	if _page_number < len(_pages_data) - 1:
		_page_number += 1
	_show_ayaat()
