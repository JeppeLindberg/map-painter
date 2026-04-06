extends Node

@onready var resource_mgt = get_node('/root/main/resource_mgt')

func accept_turn():
	# TODO: Consume resource packs to gain ducats
	pass

func add_resource(faction, resource_name, amount):
	if faction == 'blue' and resource_name == 'stone':
		await resource_mgt.add_resource(faction, 'ducats', amount * 0.5)
