extends Control

onready var _background = $ColorRect
onready var _number_label = $HBoxContainer/NumberLabel
onready var _arabic_label = $HBoxContainer/ArabicLabel

const _HEADER_COLOUR:Color = Color(0.15, 0.15, 0.15)

func _ready():
	if _background.color != _HEADER_COLOUR: # not header
		var intensity = 0.1 + (randf() * 0.2)
		_background.color.r = intensity
		_background.color.g = intensity + 0.15
		_background.color.b = intensity + 0.30

	# Expand to fit contents; +N so tashkeel (kasra) don't get cut off
	self.rect_min_size.y = _arabic_label.get_minimum_size().y + 20

# Called after _ready
func setup(ayah_number:int, arabic_text:String) -> void:
	_number_label.text = "(%s)" % ayah_number
	_arabic_label.arabic_input = arabic_text
	
func show_header():
	_number_label.queue_free()
	_background.color = _HEADER_COLOUR
	pass # TODO: font override/bigger somehow
	# TODO: center text, too
