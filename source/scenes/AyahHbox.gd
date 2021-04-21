extends Control

func _ready():
	$ColorRect.color.r = randf() 
	$ColorRect.color.g = randf() 
	$ColorRect.color.b = randf()
