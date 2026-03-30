@tool
extends Panel

@export_range(0.0,1.0) var visual_fill = 1.0
@export var radial_textures:Array[TextureRect] = []

var progress = 0.0


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if progress < 1.0:
			progress += delta * 0.5
			if progress >= 1.0:
				progress = 1.0

		visual_fill = progress

		if progress >= 1.0:
			progress = 0.0

	for texture in radial_textures:
		texture.material.set_shader_parameter('fill_ratio', visual_fill)

func start_timer():
	progress = 0.0
