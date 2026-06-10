extends Node

@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var tiles = get_node('/root/main/tiles')



func add_tradable_resource(faction, resource_name, amount):
	if faction == 'neutral':
		return

	print(resource_name + ' ' + str(amount))
