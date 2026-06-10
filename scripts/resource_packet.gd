extends Node2D

var faction = ''
var resource_name = ''
var amount = 0.0

@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var trade_mgt = get_node('/root/main/trade_mgt')


func resolve_packet():
	if resource_name in ['manpower']:
		resource_mgt.add_saveable_resource(faction, resource_name, amount)

	if resource_name in ['wood', 'stone']:
		trade_mgt.add_tradable_resource(faction, resource_name, amount)

	queue_free()
