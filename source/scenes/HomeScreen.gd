extends Node2D

const ShowSurahScene = preload("res://scenes/ShowSurahScene.tscn")

onready var _page_number_text = $PageNumberText

func _on_GoPageButton_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var page_number = _page_number_text.text.strip_edges()
		
		# UGH, godot returns 0 if the parsed value isn't an int
		page_number = int(page_number)
		if page_number > 0:
			var show_surah_scene = ShowSurahScene.instance()
			show_surah_scene.setup(page_number)
			get_tree().change_scene_to(show_surah_scene)
