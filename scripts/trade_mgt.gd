extends Node

@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var tiles = get_node('/root/main/tiles')


func accept_turn():
	for tile in tiles.get_children():
		var packets = tile.get_resource_packets()

		for i in range(len(packets) -1, -1, -1):
			if packets[i].resource_name == 'stone':
				await resource_mgt.add_resource(tile.faction, 'ducats', packets[i].amount * 0.1)
				packets[i].queue_free();
