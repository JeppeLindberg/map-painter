@tool
extends PanelContainer

@export_range(0.0,1.0) var visual_fill = 1.0

func _process(_delta: float) -> void:
	custom_minimum_size.x = int(get_parent().size.x * visual_fill)
