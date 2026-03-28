extends Node

@export var tile_information: Control



func open_left_window(tile):
	tile_information.open = true

	tile_information.barracks_level = tile.get_building_level('barracks')

func close_left_window():
	tile_information.open = false
