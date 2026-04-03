extends Node

@export var tile_information: Control



func open_left_window(tile):
	tile_information.open = true

	tile_information.tile = tile

func close_left_window():
	tile_information.open = false
