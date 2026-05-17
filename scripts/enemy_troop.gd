extends Node2D


var target_tile = null

@export var intent_arrow: Node2D

var morale = 100.0
var broken = 100.0

@export var main_color: Color
@export var secondary_color: Color


func _ready() -> void:
	add_to_group('troop')
	add_to_group('enemy_troop')

func _process(_delta):
	# if target_tile == null:
	# 	intent_arrow.visible = false
	# 	target_tile = get_tile().get_neighbours().pick_random()
	# else:
	# 	intent_arrow.visible = true
	# 	intent_arrow.look_at(target_tile.global_position)

	if get_tile().get_faction() != 'red':
		get_tile().paint('red')

func commit_turn():
	pass
	# if target_tile == null:
	# 	target_tile = get_tile().get_neighbours().pick_random()

	# if (target_tile != null):
	# 	reparent(target_tile)
	# 	position = Vector2.ZERO
	# 	target_tile.paint('red')
	
	# target_tile = null
	
func get_tile():
	return get_parent().get_parent()
