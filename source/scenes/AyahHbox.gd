extends Control

func _ready():
	$ColorRect.color.r = randf() * 0.25
	$ColorRect.color.g = randf() * 0.5
	$ColorRect.color.b = randf() * 0.75
