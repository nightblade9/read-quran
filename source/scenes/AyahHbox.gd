extends Control

onready var _hbox_container = $HBoxContainer
onready var _number_label = $HBoxContainer/NumberLabel
onready var _arabic_label = $HBoxContainer/ArabicLabel

const _HEADER_COLOUR:Color = Color(0.15, 0.15, 0.15)

func _ready():
	# Unique stylebox for unique background
	var stylebox:StyleBoxFlat = _arabic_label.get_stylebox("normal").duplicate()
	_arabic_label.add_stylebox_override("normal", stylebox)


# Called after _ready
func setup(ayah_number:int, arabic_text:String) -> void:
	_number_label.text = "(%s)" % ayah_number
	_arabic_label.arabic_input = arabic_text

	# Expand to fit contents; +N so tashkeel (kasra) don't get cut off
	self.rect_min_size.y = _arabic_label.get_minimum_size().y + 20
	
func show_header():
	_number_label.queue_free()
	_arabic_label.get_stylebox("normal").bg_color = _HEADER_COLOUR
	_arabic_label.align = Label.ALIGN_CENTER
	
	# Increase font size
	var font = _arabic_label.get_font("font", "")
	font = font.duplicate()
	font.set_size(96)
	_arabic_label.add_font_override("font", font)

	# Remove space at the top so text isn't clipped on the bottom
	_hbox_container.margin_top = -30
