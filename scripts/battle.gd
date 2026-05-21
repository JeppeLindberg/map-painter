extends Node2D


@export var left_battle_panel: Control
@export var right_battle_panel: Control

var left_troop = null
var right_troop = null



func begin(new_left_troop, new_right_troop):
	left_troop = new_left_troop
	right_troop = new_right_troop

	left_battle_panel.troop = left_troop
	right_battle_panel.troop = right_troop

	if left_troop.has_method('go_to_battle_state'):
		left_troop.go_to_battle_state()
	if right_troop.has_method('go_to_battle_state'):
		right_troop.go_to_battle_state()
