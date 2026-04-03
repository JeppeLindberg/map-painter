@tool
extends Panel

@export_range(0.0,1.0) var visual_fill = 1.0
@export var radial_textures:Array[TextureRect] = []
@export var remaining_turns_text = RichTextLabel

var progress = 0.0
var remaining_turns = 5


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		visual_fill = progress

	for texture in radial_textures:
		texture.material.set_shader_parameter('fill_ratio', clamp(visual_fill, 0.0, 1.0))
	
	remaining_turns_text.text = str(remaining_turns)
