extends Node2D

@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var trade_mgt = get_node('/root/main/trade_mgt')

@export var base_stone_production = 0.0

@export var resource_packet_prefab: PackedScene


func get_resource_production(resource_name):
	match resource_name:
		'stone':
			return base_stone_production
	
	return 0.0

func create_packets():
	if base_stone_production > 0.0:
		var stone = resource_packet_prefab.instantiate()
		add_child(stone)
		stone.resource_name = 'stone'
		stone.amount = base_stone_production
