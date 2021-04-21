extends Node2D

const ShowQuranScene = preload("res://scenes/ShowQuranScene.tscn")

onready var _page_number_text = $PageNumberText

func _on_GoPageButton_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var page_number = _page_number_text.text.strip_edges()
		page_number = int(page_number)
		if page_number > 0:
			var scene = ShowQuranScene.instance()
			scene.setup_page(page_number)
			var root = get_tree().root
			root.add_child(scene)
			root.remove_child(self)
	
func show_surah(surah_number:int) -> void:
	var scene = ShowQuranScene.instance()
	scene.setup_surah(surah_number)
	get_tree().change_scene_to(scene)
