@tool
extends VBoxContainer

@export var pause = false

@export var battle_panel_morale: Control
@export var battle_panel_morale_meter: Control
@export var battle_panel_break: Control
@export var battle_panel_break_meter: Control
@export var soldier_count: RichTextLabel

@export var left = true

var troop: Node2D

@export var colorize_main: Array[CanvasItem]
@export var colorize_secondary: Array[CanvasItem]

func _process(_delta: float) -> void:
	if pause:
		return

	for child:PanelContainer in battle_panel_morale.get_children() + battle_panel_break.get_children():
		if left:
			child.size_flags_horizontal = Control.SIZE_SHRINK_END
		else:
			child.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	
	if Engine.is_editor_hint():
		return
	
	if troop != null:
		for node in colorize_main:
			node.self_modulate = troop.main_color
		for node in colorize_secondary:
			node.self_modulate = troop.secondary_color

		battle_panel_morale_meter.visual_fill = clamp(remap(troop.morale, 0.0, 100.0, 0.0, 1.0), 0.0, 1.0)
		battle_panel_break_meter.visual_fill = clamp(remap(troop.broken, 0.0, 100.0, 0.0, 1.0), 0.0, 1.0)

		soldier_count.text = str(troop.get_number_of_soldiers())
	
