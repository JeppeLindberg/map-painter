class_name Troop
extends Node2D

@onready var tiles = get_node('/root/main/tiles')

@export var soldiers: Node

var faction = 'blue'
var target_tile = null

var state = 'idle'

var morale = 100.0
var broken = 100.0


func _ready() -> void:
	add_to_group('troop')

func go_to_move_to_state():
	state = 'move_to'

func go_to_battle_state():
	state = 'battle'

func quit_battle_state():
	state = 'move_to'

func go_to_idle_state():
	state = 'idle'

func go_to_retreat_state():
	state = 'retreat'

	target_tile = tiles.get_capital_of(faction)

func get_tile():
	return get_parent().get_parent()

func unit_clicked():
	select()

func select():
	pass

func deselect():
	pass

func calculate_attack_power():
	return float(get_number_of_soldiers())

func take_damage(attack_power):
	_take_morale_damage(attack_power * 2.0)
	_take_soldier_damage(attack_power / 10.0)

func _take_morale_damage(attack_power):
	morale -= 10 + (attack_power * randf_range(0.8, 1.2))
	if morale <= 0.0:
		morale = 0.0

func _take_soldier_damage(attack_power):
	var remaining_damage = attack_power

	while remaining_damage > 0.0:		
		if get_number_of_soldiers() == 0:
			break

		var target_solder = null

		for soldier in get_soldiers():
			if soldier.health < soldier.max_health:
				target_solder = soldier
		
		if target_solder == null:
			target_solder = get_soldiers().pick_random()
		
		if target_solder.health < remaining_damage:
			remaining_damage -= target_solder.health
			target_solder.health = 0.0
			target_solder.queue_free()
		else:
			var damage = remaining_damage
			remaining_damage -= target_solder.health
			target_solder.health -= damage
	
	if get_number_of_soldiers() == 0:
		queue_free()

func get_soldiers():
	var soldiers_arr = soldiers.get_children()

	for i in range(len(soldiers_arr) -1, -1, -1):
		if soldiers_arr[i].is_queued_for_deletion():
			soldiers_arr.remove_at(i)

	return soldiers_arr

func get_number_of_soldiers():
	return len(get_soldiers())

func commit_turn():
	match state:
		'move_to', 'retreat':
			var one_step_target = get_tile().get_step_toward(target_tile)
			if (one_step_target != null):
				one_step_target.add_troop(self)
				one_step_target.paint(faction)

			if target_tile == get_tile():
				go_to_idle_state()
