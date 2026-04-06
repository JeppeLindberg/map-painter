extends Node


@onready var tiles = get_node('/root/main/tiles')

var ducats = 1.0



func get_resource(faction, resource_name):
	if faction == 'blue' and resource_name == 'ducats':
		return ducats

func prepare_turn():
	for tile in tiles.get_children():
		await tile.create_resource_packets()


func add_resource(faction, resource_name, amount):
	if faction == 'blue' and resource_name == 'ducats':
		ducats += amount

