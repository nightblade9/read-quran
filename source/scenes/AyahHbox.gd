extends Control

onready var _background = $ColorRect
onready var _arabic_label = $TemplateHBox/ArabicLabel

func _ready():
	_background.color.r = randf() * 0.40
	_background.color.g = randf() * 0.50
	_background.color.b = randf() * 0.65

	# Expand to fit contents; +N so tashkeel (kasra) don't get cut off
	self.rect_min_size.y = _arabic_label.get_minimum_size().y + 20
