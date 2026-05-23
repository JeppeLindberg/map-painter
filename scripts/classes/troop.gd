class_name Troop
extends Node2D

@export var soldiers: Node

var state = 'idle'


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

func get_tile():
	return get_parent().get_parent()

func unit_clicked():
	select()

func select():
	pass

func deselect():
	pass

func calculate_attack_power():
	return get_number_of_soldiers() / 10.0

func take_damage(attack_power):
	print(attack_power)
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
