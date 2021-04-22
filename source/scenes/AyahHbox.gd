extends Control

func _ready():
	$ColorRect.color.r = randf() * 0.60
	$ColorRect.color.g = randf() * 0.70
	$ColorRect.color.b = randf() * 0.75
