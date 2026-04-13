extends Node2D

var utils = preload("res://scripts/utils.gd").new()

@export var task_text = 'Recruiting troop...'



func get_text():
	return task_text

func task_finished():
	var tile = utils.find_parent_in_group(self, 'tile')
	if tile == null:
		return

	print('bla')
	# tile.level_building_to(building_name, tile.get_building_level(building_name) + 1)
