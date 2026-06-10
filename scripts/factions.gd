extends Node


func get_faction(faction_name):
	for child in get_children():
		if child.faction_name == faction_name:
			return child

	return null

