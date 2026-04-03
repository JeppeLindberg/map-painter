extends Node2D

@export var upgrade_barracks_prefab: PackedScene

@onready var turn_timer = get_node('/root/main/camera/turn_timer')


func enqueue_task(task_name, parameter_1):
	var new_task = null
	if task_name == 'upgrade' and parameter_1 == 'barracks':
		new_task = upgrade_barracks_prefab.instantiate()

	if new_task != null:
		if get_child_count() == 0:
			new_task.task_start_dec = turn_timer.dec
			new_task.task_end_dec = ceil(turn_timer.dec) + new_task.turn_duration - 1.0
			new_task.task_start_turn = turn_timer.turn
			new_task.task_end_turn = turn_timer.turn + new_task.turn_duration
		else:
			var previous_task_end_dec = 0.0
			var previous_task_end_turn = 0

			for task in get_children():
				if task.task_end_turn > previous_task_end_turn:
					previous_task_end_turn = task.task_end_turn
				if task.task_end_dec > previous_task_end_dec:
					previous_task_end_dec = task.task_end_dec

			new_task.task_start_dec = previous_task_end_dec
			new_task.task_end_dec = previous_task_end_dec + new_task.turn_duration
			new_task.task_start_turn = previous_task_end_turn
			new_task.task_end_turn = previous_task_end_turn + new_task.turn_duration


	add_child(new_task)