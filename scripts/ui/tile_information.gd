@tool
extends Panel

var utils = preload("res://scripts/utils.gd").new()

@export var scroll: ScrollContainer
@export var first_child_of_scroll: MarginContainer

@export var buildings_control: Control
@export var tasks_control: Control

@export var barracks_prefab: PackedScene


@export_range(0.0,1.0) var expand_pct = 1.0

var tile = null
var open = false

var text = ''


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if open:
			expand_pct = min(expand_pct + (delta * 4.0), 1.0)
			expand_pct = min(get_parent().size.y * expand_pct, first_child_of_scroll.size.y) / max(get_parent().size.y, first_child_of_scroll.size.y)
		else:
			expand_pct = max(expand_pct - (delta * 4.0), 0.0)

		if tile != null:
			var tile_tasks = tile.get_tasks()
			if len(tile_tasks) > 0:
				tasks_control.task = tile_tasks[0]
			else:
				tasks_control.clear()
				
			if tile.get_building_level('barracks') != -1:
				if utils.get_children_in_group(buildings_control, 'barracks') == []:
					var barracks = barracks_prefab.instantiate()
					buildings_control.add_child(barracks)
				
				for building in utils.get_children_in_group(buildings_control, 'barracks'):
					building.tile = tile
			else:
				for child in utils.get_children_in_group(buildings_control, 'barracks'):
					child.queue_free()



	scroll.custom_minimum_size.y = first_child_of_scroll.size.y
	custom_minimum_size.y = snapped(get_parent().size.y * expand_pct, 2.0)
