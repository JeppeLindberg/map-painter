@tool
extends Node2D

@export var turn_mgt:Node

@export_range(0.0,1.0) var visual_fill = 1.0
@export var radial_sprites:Array[Sprite2D] = []

var dec = 0.0
var turn = 0

var between_turns = false


func _ready() -> void:
	if not Engine.is_editor_hint():
		await turn_mgt.prepare_turn()

func _process(delta: float) -> void:
	var trigger_turn = false
	if not Engine.is_editor_hint():
		if not between_turns:
			dec += delta * 0.5
			if int(floor(dec)) != turn:
				trigger_turn = true

		if trigger_turn or between_turns:
			visual_fill = 1.0
		else:
			visual_fill = dec - floor(dec)

	for sprite in radial_sprites:
		sprite.material.set_shader_parameter('fill_ratio', visual_fill)

	if trigger_turn:
		dec = floor(dec)
		turn += 1
		between_turns = true
		accept_turn()

func accept_turn():
	await turn_mgt.commit_turn()	
	await turn_mgt.prepare_turn()

func start_timer():
	between_turns = false
