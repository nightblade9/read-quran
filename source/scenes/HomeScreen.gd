extends Node2D

onready var _page_number_text = $PageNumberText

func _on_GoPageButton_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var page_number = _page_number_text.text.strip_edges()
		# UGH, godot returns 0 if the parsed value isn't an int
		if page_number == "0":
			page_number = 0 # legit page 0
			print("Goto page ZERO")
		else:
			page_number = int(page_number)
			if page_number > 0:
				print("Goto page %s" % page_number)
