extends Node

@export var tile_information: Control



func open_left_window(text):
	tile_information.text = text
	tile_information.open = true

func close_left_window():
	tile_information.open = false
