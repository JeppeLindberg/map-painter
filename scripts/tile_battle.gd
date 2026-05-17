extends Node2D


@onready var troops = get_node('../troops')

@export var battle:PackedScene


func auto_create_battle():
	if get_child_count() > 0:
		return

	var left_troop = null
	var right_troop = null

	for troop in troops.get_children():
		if left_troop == null and troop.is_in_group('player_troop'):
			left_troop = troop
		if right_troop == null and troop.is_in_group('enemy_troop'):
			right_troop = troop

	if left_troop != null and right_troop != null:
		var new_battle = battle.instantiate()
		add_child(new_battle)
		new_battle.begin(left_troop, right_troop)


