extends Node2D


@onready var troops = get_node('../troops')

@export var battle:PackedScene


func auto_create_battle():
	var containing_groups = []

	for troop in troops.get_children():
		if not containing_groups.has('player_troop') and troop.is_in_group('player_troop'):
			containing_groups.append('player_troop')
		if not containing_groups.has('enemy_troop') and troop.is_in_group('enemy_troop'):
			containing_groups.append('enemy_troop')

	if containing_groups.has('player_troop') and containing_groups.has('enemy_troop'):
		var new_battle = battle.instantiate()
		add_child(new_battle)


