@tool
extends Node2D

@export var buildings_container: Container

@export var barracks_prefab: PackedScene


func _process(_delta: float) -> void:
	if buildings_container.get_child_count() == 0:
		visible = false
	else:
		visible = true

func create_building(building_name, level):
	var new_building = null
	match building_name:
		'barracks':
			new_building = barracks_prefab.instantiate()

	buildings_container.add_child(new_building)
	if Engine.is_editor_hint():
		new_building.owner = get_tree().edited_scene_root
	new_building.add_to_group('building_name')
	new_building.set_level(level)
