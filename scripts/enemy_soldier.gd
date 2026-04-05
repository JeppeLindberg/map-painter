extends Node2D


var target_tile = null

@export var intent_arrow: Node2D


func _ready() -> void:
	add_to_group('occupant')
	add_to_group('enemy_soldier')

func _process(_delta):
	if target_tile == null:
		intent_arrow.visible = false
		target_tile = get_parent().get_neighbours().pick_random()
	else:
		intent_arrow.visible = true
		intent_arrow.look_at(target_tile.global_position)

	if get_parent().get_faction() != 'red':
		get_parent().paint('red')

func accept_turn():
	if target_tile == null:
		target_tile = get_parent().get_neighbours().pick_random()

	if (target_tile != null) and (target_tile.get_current_occupant() == null):
		reparent(target_tile)
		position = Vector2.ZERO
		target_tile.paint('red')
	
	target_tile = null
