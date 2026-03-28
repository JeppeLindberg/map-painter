extends Node2D

@export var buildings_container: Container



func _process(_delta: float) -> void:
	if buildings_container.get_child_count() == 0:
		visible = false
	else:
		visible = true


