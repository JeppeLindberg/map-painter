extends Node

var utils = preload("res://scripts/utils.gd").new()

@onready var ui_mgt = get_node('/root/main/ui_mgt')
@onready var main = get_node('/root/main')

var current_selection = null


func deselect_all():
	for node in utils.get_children_in_group(main, 'player_units'):
		node.deselect()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("deselect"):
		deselect_all()
		ui_mgt.close_left_window()

func tile_clicked(tile):
	current_selection = null

	var something_selected = false
	for child in tile.get_children():
		if child.is_in_group('player_units'):
			child.select()
			current_selection = child
			something_selected = true
		
	if not something_selected:
		tile.show_information()
		current_selection = tile
		something_selected = true
