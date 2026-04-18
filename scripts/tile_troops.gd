extends Node2D

@export var troop_prefab: PackedScene


func add_troop(troop_node):
	troop_node.reparent(self)

func spawn_troop():
	var new_troop = troop_prefab.instantiate()
	add_child(new_troop)

