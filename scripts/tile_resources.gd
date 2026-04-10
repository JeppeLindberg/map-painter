extends Node2D

@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var trade_mgt = get_node('/root/main/trade_mgt')
@onready var tile = get_parent()

@export var resource_name = 'stone'
@export var base_production = 0.0

@export var resource_packet_prefab: PackedScene


func get_resource_production(resource):
	var result = 0.0

	if resource == resource_name:
		result += base_production

	if resource == 'manpower':
		result += float(tile.get_building_level('barracks'))
	
	return result

func create_packets():
	for resource in ['stone', 'manpower']:	
		if get_resource_production(resource) > 0.0:
			var new_resource_packet = resource_packet_prefab.instantiate()
			add_child(new_resource_packet)
			new_resource_packet.resource_name = resource
			new_resource_packet.amount = get_resource_production(resource)

func get_packets():
	return get_children()

