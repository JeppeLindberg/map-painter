@tool
extends Node2D

@export var turn_mgt:Node

@export_range(0.0,1.0) var visual_fill = 1.0
@export var radial_sprites:Array[Sprite2D] = []

var progress = 0.0


func _process(delta: float) -> void:
	var trigger_turn = false
	if not Engine.is_editor_hint():
		if progress < 1.0:
			progress += delta * 0.5
			if progress >= 1.0:
				progress = 1.0
				trigger_turn = true

		visual_fill = 1.0 - progress

	for sprite in radial_sprites:
		sprite.material.set_shader_parameter('fill_ratio', visual_fill)

	if trigger_turn:
		turn_mgt.accept_turn()

func start_timer():
	progress = 0.0
