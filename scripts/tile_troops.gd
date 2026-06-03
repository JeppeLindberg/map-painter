extends Node2D

@export var blue_troop_prefab: PackedScene
@export var red_troop_prefab: PackedScene

@onready var battle = get_node('../battle')


func add_troop(troop_node):
	troop_node.reparent(self)
	troop_node.position = Vector2.ZERO

	battle.auto_create_battle()

func spawn_troop(faction):
	var new_troop = null
	match faction:
		'blue':
			new_troop = blue_troop_prefab.instantiate()
		'red':
			new_troop = red_troop_prefab.instantiate()

	if new_troop != null:
		add_child(new_troop)
