@tool
extends Panel

var utils = preload("res://scripts/utils.gd").new()

@export var scroll: ScrollContainer
@export var first_child_of_scroll: MarginContainer

@export var buildings_control: Control
@export var troops_control: Control
@export var tasks_control: Control
@export var resources_control: Control

@export var barracks_prefab: PackedScene

@export var troop_tile_information_prefab: PackedScene

@export var resource_indicator_container_prefab: PackedScene
@export var resource_indicator_prefab: PackedScene
@export var resource_indicator_filler_prefab: PackedScene


@export_range(0.0,1.0) var expand_pct = 1.0

var tile = null
var open = false

var text = ''
var prev_resources = []


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
				
			if utils.get_children_in_group(buildings_control, 'barracks') == []:
				var barracks = barracks_prefab.instantiate()
				buildings_control.add_child(barracks)
			
			for building in utils.get_children_in_group(buildings_control, 'barracks'):
				building.tile = tile
				
			if tile.get_building_level('barracks') != 0:
				if troops_control.main_vbox.get_child_count() == 0:
					var troop = troop_tile_information_prefab.instantiate()
					troops_control.main_vbox.add_child(troop)

				for child in troops_control.main_vbox.get_children():
					child.tile = tile

				troops_control.visible = true
			else:
				for child in troops_control.main_vbox.get_children():
					child.queue_free()
				troops_control.visible = false
			
			var resources_to_add = []
			for resource_name in ['stone', 'manpower']:
				if tile.get_resource_production(resource_name) != 0.0:
					resources_to_add.append([resource_name, tile.get_resource_production(resource_name)])

			if prev_resources != resources_to_add:
				for child in resources_control.get_children():
					child.queue_free()

				var pair = 0
				var container = null
				for resource_pair in resources_to_add:
					if pair == 0:
						container = resource_indicator_container_prefab.instantiate()
						resources_control.add_child(container)
					
					var new_resource = resource_indicator_prefab.instantiate()
					container.add_child(new_resource)
					new_resource.set_info(resource_pair[0], resource_pair[1])

					pair += 1
					pair = pair % 2
				
				if pair == 1:
					var filler = resource_indicator_filler_prefab.instantiate()
					container.add_child(filler)
				
				prev_resources = resources_to_add



	scroll.custom_minimum_size.y = first_child_of_scroll.size.y
	custom_minimum_size.y = snapped(get_parent().size.y * expand_pct, 2.0)
