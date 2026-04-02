@tool
extends Panel

var utils = preload("res://scripts/utils.gd").new()

@export var scroll: ScrollContainer
@export var first_child_of_scroll: MarginContainer

@export var buildings_main_vbox: Control

@export var barracks_prefab: PackedScene


@export_range(0.0,1.0) var expand_pct = 1.0

var open = false

var text = ''
var barracks_level = 0


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if open:
			expand_pct = min(expand_pct + (delta * 4.0), 1.0)
			expand_pct = min(get_parent().size.y * expand_pct, first_child_of_scroll.size.y) / max(get_parent().size.y, first_child_of_scroll.size.y)
		else:
			expand_pct = max(expand_pct - (delta * 4.0), 0.0)
			
		if barracks_level != -1:
			var barracks_children = utils.get_children_in_group(buildings_main_vbox, 'barracks')
			if barracks_children == []:
				var barracks = barracks_prefab.instantiate()
				buildings_main_vbox.add_child(barracks)
				barracks.add_to_group('barracks')
				barracks.level = barracks_level
			else:
				barracks_children[0].level = barracks_level


	scroll.custom_minimum_size.y = first_child_of_scroll.size.y
	custom_minimum_size.y = snapped(get_parent().size.y * expand_pct, 2.0)
