extends Node


@onready var tiles = get_node('/root/main/tiles')

var ducats = 1.0
var manpower = 1.0



func get_resource(faction, resource_name):
	if faction == 'blue' and resource_name == 'ducats':
		return ducats
	if faction == 'blue' and resource_name == 'manpower':
		return manpower

func prepare_turn():
	for tile in tiles.get_children():
		await tile.create_resource_packets()

func accept_turn():
	for tile in tiles.get_children():
		var packets = tile.get_resource_packets()

		for i in range(len(packets) -1, -1, -1):
			if packets[i].resource_name == 'manpower':
				add_resource(tile.faction, 'manpower', packets[i].amount)
				packets[i].queue_free();

func add_resource(faction, resource_name, amount):
	if faction == 'blue' and resource_name == 'ducats':
		ducats += amount
	if faction == 'blue' and resource_name == 'manpower':
		manpower += amount

