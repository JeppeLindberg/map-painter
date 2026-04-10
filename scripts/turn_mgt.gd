extends Node


var utils = preload("res://scripts/utils.gd").new()
@onready var main = get_node('/root/main')
@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var trade_mgt = get_node('/root/main/trade_mgt')

@export var timer: Node2D


func prepare_turn():
	await get_tree().process_frame
	
	await resource_mgt.prepare_turn()

func accept_turn():
	await get_tree().process_frame

	await trade_mgt.accept_turn()
	
	await resource_mgt.accept_turn()

	for task in utils.get_children_in_group(main, 'task'):
		await task.accept_turn()

	for player_soldier in utils.get_children_in_group(main, 'player_soldier'):
		await player_soldier.accept_turn()

	for enemy_soldier in utils.get_children_in_group(main, 'enemy_soldier'):
		await enemy_soldier.accept_turn()

	timer.start_timer()
