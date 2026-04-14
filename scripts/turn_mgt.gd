extends Node


var utils = preload("res://scripts/utils.gd").new()
@onready var main = get_node('/root/main')
@onready var resource_mgt = get_node('/root/main/resource_mgt')
@onready var trade_mgt = get_node('/root/main/trade_mgt')

@export var timer: Node2D


func prepare_turn():
	await get_tree().process_frame
	
	await resource_mgt.prepare_turn()

func commit_turn():
	await get_tree().process_frame

	await trade_mgt.commit_turn()
	
	await resource_mgt.commit_turn()

	for task in utils.get_children_in_group(main, 'task'):
		await task.commit_turn()

	for player_soldier in utils.get_children_in_group(main, 'player_troop'):
		await player_soldier.commit_turn()

	for enemy_soldier in utils.get_children_in_group(main, 'enemy_soldier'):
		await enemy_soldier.commit_turn()

	timer.start_timer()
