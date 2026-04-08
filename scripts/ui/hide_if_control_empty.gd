@tool
extends PanelContainer


@export var target_control: Control


func _process(_delta: float) -> void:
	var new_visible = false
	for child in target_control.get_children():
		if child.visible:
			new_visible = true
	
	if visible != new_visible:
		visible = new_visible
