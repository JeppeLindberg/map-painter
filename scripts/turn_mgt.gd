extends Node


var utils = preload("res://scripts/utils.gd").new()
@onready var main = get_node('/root/main')

@export var timer: Node2D


func accept_turn():
	await get_tree().process_frame

	for task in utils.get_children_in_group(main, 'task'):
		await task.accept_turn()

	for player_soldier in utils.get_children_in_group(main, 'player_soldier'):
		await player_soldier.accept_turn()

	for enemy_soldier in utils.get_children_in_group(main, 'enemy_soldier'):
		await enemy_soldier.accept_turn()

	timer.start_timer()
