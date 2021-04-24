extends Control

onready var _background = $ColorRect
onready var _number_label = $HBoxContainer/NumberLabel
onready var _arabic_label = $HBoxContainer/ArabicLabel

func _ready():
	_background.color.r = randf() * 0.40
	_background.color.g = randf() * 0.50
	_background.color.b = randf() * 0.65

	# Expand to fit contents; +N so tashkeel (kasra) don't get cut off
	self.rect_min_size.y = _arabic_label.get_minimum_size().y + 20

# Called after _ready
func setup(ayah_number:int, arabic_text:String) -> void:
	_number_label.text = "(%s)" % ayah_number
	_arabic_label.arabic_input = arabic_text

func show_header():
	_number_label.queue_free()
	pass # TODO: override/bigger somehow
	# TODO: center text, too
