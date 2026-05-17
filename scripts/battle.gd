extends Node2D


@export var left_battle_panel: Control
@export var right_battle_panel: Control

var left_troop = null
var right_troop = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func begin(new_left_troop, new_right_troop):
	left_troop = new_left_troop
	right_troop = new_right_troop

	left_battle_panel.troop = left_troop
	right_battle_panel.troop = right_troop
