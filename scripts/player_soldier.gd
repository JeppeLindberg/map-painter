extends Node2D

@export var pathfinding_clickable_prefab: PackedScene

var utils = preload("res://scripts/utils.gd").new()
@onready var pathfinding_clickables = get_node('pathfinding_clickables')

var state = 'idle'

var target_tile = null


func _ready() -> void:
	add_to_group('occupant')
	add_to_group('player_soldier')

func _process(_delta: float) -> void:
	if get_parent().get_color() != 'player':
		get_parent().paint('player')

	match state:
		'idle':	
			go_to_select_movement_state()

func accept_turn():
	match state:
		'move_to':
			var one_step_target = get_parent().get_step_toward(target_tile)
			if (one_step_target != null) and (one_step_target.get_current_occupant() == null):
				reparent(one_step_target)
				position = Vector2.ZERO
				one_step_target.paint('player')

				create_pathfinding_clickables()

			if target_tile == get_parent():
				go_to_idle_state()


func go_to_select_movement_state():
	reset_state()
	state = 'select_movement'
	create_pathfinding_clickables()

func go_to_move_to_state():
	reset_state()
	state = 'move_to'
	create_pathfinding_clickables()

func go_to_idle_state():
	reset_state()
	state = 'idle'

func create_pathfinding_clickables():
	for child in pathfinding_clickables.get_children():
		child.queue_free()

	for tile in get_parent().get_tiles_explore(10):
		var pathfinding_clickable = pathfinding_clickable_prefab.instantiate()
		pathfinding_clickables.add_child(pathfinding_clickable)
		pathfinding_clickable.global_position = tile.global_position
		pathfinding_clickable.callback_callable = pathfinding_clickable_clicked
		pathfinding_clickable.tile = tile

func pathfinding_clickable_clicked(caller):
	target_tile = caller.tile
	go_to_move_to_state()

func reset_state():
	for child in pathfinding_clickables.get_children():
		child.queue_free()


			
