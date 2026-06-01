extends Node2D


@export var left_battle_panel: Control
@export var right_battle_panel: Control

var left_troop = null
var right_troop = null

@onready var troops = get_node('../../troops')


func _ready() -> void:
	add_to_group('battle')


func begin(new_left_troop, new_right_troop):
	left_troop = new_left_troop
	right_troop = new_right_troop

	left_battle_panel.troop = left_troop
	right_battle_panel.troop = right_troop

	left_troop.go_to_battle_state()
	right_troop.go_to_battle_state()

func commit_turn():
	var attack_powers = []
	for troop in battling_troops():
		attack_powers.append({
			'source': troop,
			'attack_power': troop.calculate_attack_power()
		})

	for attack_power in attack_powers:
		for troop in battling_troops():
			if troop != attack_power['source']:
				troop.take_damage(attack_power['attack_power'])

	for troop in battling_troops():
		if troop.morale == 0.0:
			troop.go_to_retreat_state()

	var remaining_factions = []
	for troop in battling_troops():		
		if troop.is_in_group('troop_player'):
			if not 'troop_player' in remaining_factions:
				remaining_factions.append('troop_player')
		if troop.is_in_group('troop_enemy'):
			if not 'troop_enemy' in remaining_factions:
				remaining_factions.append('troop_enemy')

		if len(remaining_factions) >= 2:
			break
	
	if len(remaining_factions) < 2:
		for troop in battling_troops():		
			troop.quit_battle_state()
			
		queue_free()
	


func battling_troops():
	var result = []
	for troop in troops.get_children():
		if troop.is_queued_for_deletion():
			continue
		if troop.state != 'battle':
			continue
		result.append(troop)
	
	return result

	
