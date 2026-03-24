extends Node2D


var planned_movement = Vector2i.ZERO

@export var intent_arrow: Node2D


func _ready() -> void:
	add_to_group('occupant')
	add_to_group('enemy_soldier')

func _process(_delta):
	if planned_movement == Vector2i.ZERO:
		intent_arrow.visible = false
		planned_movement = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT].pick_random()
	else:
		intent_arrow.visible = true
		intent_arrow.look_at(intent_arrow.global_position + planned_movement*10.0)

	if get_parent().get_color() != 'enemy':
		get_parent().paint('enemy')

func accept_turn():
	if planned_movement == Vector2i.ZERO:
		planned_movement = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT].pick_random()

	var target_tile = get_parent().get_relative_tile(planned_movement)
	if (target_tile != null) and (target_tile.get_current_occupant() == null):
		reparent(target_tile)
		position = Vector2.ZERO
		target_tile.paint('enemy')
	
	planned_movement = Vector2i.ZERO
