extends Node2D


@onready var turn_timer = get_node('/root/main/camera/turn_timer')

@export var turn_duration = 5


var task_start_dec: float = 0.0
var task_end_dec: float = 1.0

var task_start_turn: int = 0
var task_end_turn: int = 1


var progress = 0.0
var remaining_turns = 1

func _ready() -> void:
	add_to_group('task')

func _process(_delta: float) -> void:
	progress = clamp(inverse_lerp(task_start_dec, task_end_dec, turn_timer.dec), 0.0, 1.0)
	remaining_turns = abs(task_end_turn - turn_timer.turn)

func get_text():
	for child in get_children():
		if child.has_method('get_text'):
			return child.get_text()
	
	return 'Task'

func accept_turn():
	for child in get_children():
		if remaining_turns == 0:
			if child.has_method('task_finished'):
				await child.task_finished()

	if remaining_turns == 0:
		queue_free()





