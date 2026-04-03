extends Node2D

var utils = preload("res://scripts/utils.gd").new()

@export var task_text = 'Barracks level %1 → %2'
@export var building_name = 'barracks'

var text = ''


func get_text():
	if text == '':
		var tile = utils.find_parent_in_group(self, 'tile')
		text = task_text \
			.replace('%1', str(tile.get_building_level(building_name))) \
			.replace('%2', str(tile.get_building_level(building_name) + 1))
	return text

func task_finished():
	var tile = utils.find_parent_in_group(self, 'tile')
	if tile == null:
		return

	tile.level_building_to(building_name, tile.get_building_level(building_name) + 1)
