@tool
extends Node2D

var utils = preload("res://scripts/utils.gd").new()

@export var buildings_container: Container

@export var barracks_prefab: PackedScene


func _process(_delta: float) -> void:
	if buildings_container.get_child_count() == 0:
		visible = false
	else:
		visible = true

func level_building_to(building_name, level):
	var existing_buildings = utils.get_children_in_group(buildings_container, building_name)

	if existing_buildings == []:
		var new_building = null
		match building_name:
			'barracks':
				new_building = barracks_prefab.instantiate()

		if new_building != null:
			buildings_container.add_child(new_building)
			if Engine.is_editor_hint():
				new_building.owner = get_tree().edited_scene_root
			new_building.add_to_group(building_name)
			new_building.level = level
	else:
		existing_buildings[0].level = level

func get_level(building_name):
	for building in buildings_container.get_children():
		if building.is_in_group(building_name):
			return building.level
	
	return 0
