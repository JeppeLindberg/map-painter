extends Node


var utils = preload("res://scripts/utils.gd").new()
@onready var main = get_node('/root/main')
@onready var resource_mgt = get_node('/root/main/resource_mgt')

@export var timer: Node2D


func prepare_turn():
	await get_tree().process_frame
	
	await resource_mgt.prepare_turn()

	for tile in utils.get_children_in_group(main, 'tile'):
		await tile.prepare_turn()

func commit_turn():
	await get_tree().process_frame
	
	await resource_mgt.commit_turn()

	for task in utils.get_children_in_group(main, 'task'):
		await task.commit_turn()

	for battle in utils.get_children_in_group(main, 'battle'):
		await battle.commit_turn()

	for troop_player in utils.get_children_in_group(main, 'troop_player'):
		await troop_player.commit_turn()

	for troop_enemy in utils.get_children_in_group(main, 'troop_enemy'):
		await troop_enemy.commit_turn()

	timer.start_timer()
