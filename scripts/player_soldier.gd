extends Node2D

@export var pathfinding_clickable_prefab: PackedScene

var utils = preload("res://scripts/utils.gd").new()

var state = 'idle'

var target_tile = null
var selected = false


func _ready() -> void:
	add_to_group('occupant')
	add_to_group('player_soldier')
	add_to_group('player_units')

func _process(_delta: float) -> void:
	if get_parent().get_color() != 'player':
		get_parent().paint('player')

func accept_turn():
	match state:
		'move_to':
			var one_step_target = get_parent().get_step_toward(target_tile)
			if (one_step_target != null) and (one_step_target.get_current_occupant() == null):
				reparent(one_step_target)
				position = Vector2.ZERO
				one_step_target.paint('player')

				update()

			if target_tile == get_parent():
				go_to_idle_state()


@onready var prev_update = {
	'selected': selected,
	'parent': get_parent()
}

func update():
	if selected and (prev_update['parent'] != get_parent()):
		create_pathfinding_clickables()
	else:
		if (prev_update['selected'] and not selected):
			delete_pathfinding_clickables()
		if not prev_update['selected'] and selected:
			create_pathfinding_clickables()

	prev_update = {
		'selected': selected,
		'parent': get_parent()
	}


func go_to_move_to_state():
	state = 'move_to'

func go_to_idle_state():
	state = 'idle'

var pathfinding_clickables = []

func create_pathfinding_clickables():
	delete_pathfinding_clickables()

	for tile in get_parent().get_tiles_explore(10):
		var pathfinding_clickable = pathfinding_clickable_prefab.instantiate()
		tile.add_child(pathfinding_clickable)
		pathfinding_clickable.position = Vector2.ZERO
		pathfinding_clickable.callback_callable = pathfinding_clickable_clicked
		pathfinding_clickable.tile = tile
		pathfinding_clickables.append(pathfinding_clickable)
		

func pathfinding_clickable_clicked(caller):
	target_tile = caller.tile
	go_to_move_to_state()

func delete_pathfinding_clickables():
	for i in range(len( pathfinding_clickables) - 1, -1 ,-1):
		pathfinding_clickables[i].queue_free()
		pathfinding_clickables.remove_at(i)

func select():
	selected = true
	update()

func deselect():
	selected = false
	update()

			
