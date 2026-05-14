@tool
extends VBoxContainer

@export var pause = false

@export var battle_panel_morale: Control
@export var battle_panel_break: Control

@export var left = true

func _process(_delta: float) -> void:
	if pause:
		return

	for child:PanelContainer in battle_panel_morale.get_children() + battle_panel_break.get_children():
		if left:
			child.size_flags_horizontal = Control.SIZE_SHRINK_END
		else:
			child.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN


