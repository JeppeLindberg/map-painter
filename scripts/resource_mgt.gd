extends Node


@onready var tiles = get_node('/root/main/tiles')
@onready var factions = get_node('/root/main/factions')




func prepare_turn():
	for tile in tiles.get_children():
		await tile.create_resource_packets()

func commit_turn():
	for tile in tiles.get_children():
		var packets = tile.get_resource_packets()

		for i in range(len(packets) -1, -1, -1):
			packets[i].resolve_packet()

func add_saveable_resource(faction, resource_name, amount):
	if faction == 'neutral':
		return

	factions.get_faction(faction).add_resource(resource_name, amount)
