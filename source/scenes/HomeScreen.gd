extends Node2D

const ShowQuranScene = preload("res://scenes/ShowQuranScene.tscn")

onready var _page_number_text = $HBoxContainer/PageNumberText

func _on_GoPageButton_pressed():
	var page_number = _page_number_text.text.strip_edges()
	page_number = int(page_number)
	if page_number > 0:
		var scene = ShowQuranScene.instance()
		scene.setup_page(page_number)
		var root = get_tree().root
		root.add_child(scene)
		root.remove_child(self)
