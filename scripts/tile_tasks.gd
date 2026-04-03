extends Node2D

@export var upgrade_barracks_prefab: PackedScene

@onready var turn_timer = get_node('/root/main/camera/turn_timer')


func enqueue_task(task_name, parameter_1):
	var new_task = null
	if task_name == 'upgrade' and parameter_1 == 'barracks':
		new_task = upgrade_barracks_prefab.instantiate()
		new_task.task_start_dec = turn_timer.dec
		new_task.task_start_turn = turn_timer.turn
		new_task.task_end_dec = ceil(turn_timer.dec) + new_task.turn_duration
		new_task.task_end_turn = turn_timer.turn + new_task.turn_duration + 1
	
	if new_task != null:
		add_child(new_task)

