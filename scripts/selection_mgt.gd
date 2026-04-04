extends Node

var utils = preload("res://scripts/utils.gd").new()

@onready var ui_mgt = get_node('/root/main/ui_mgt')
@onready var main = get_node('/root/main')

var current_selection = null


func deselect_all():
	current_selection = null
	for node in utils.get_children_in_group(main, 'player_units'):
		node.deselect()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("deselect"):
		deselect_all()
		ui_mgt.close_left_window()

func tile_clicked(tile):
	deselect_all()
		
	tile.show_information()
	current_selection = tile
