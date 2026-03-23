extends Node


@onready var main = get_node('/root/main')

@export var timer: Node2D


func accept_turn():
	for player_soldier in main.get_children_in_group(main, 'player_soldier'):
		await player_soldier.accept_turn()

	for enemy_soldier in main.get_children_in_group(main, 'enemy_soldier'):
		await enemy_soldier.accept_turn()

	timer.start_timer()
