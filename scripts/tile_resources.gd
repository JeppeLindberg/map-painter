extends Node2D

@export var base_stone_production = 0.0


func get_resource_production(resource_name):
	match resource_name:
		'stone':
			return base_stone_production
	
	return 0.0
