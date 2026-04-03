extends Node2D


@onready var turn_timer = get_node('/root/main/camera/turn_timer')

@export var text = 'Barracks level 1 → 2'
@export var turn_duration = 5


var task_start_dec = 0.0
var task_end_dec = 1.0

var task_start_turn = 0
var task_end_turn = 1


var progress = 0.0
var remaining_turns = 1

func _ready() -> void:
	add_to_group('task')

func _process(_delta: float) -> void:
	progress = inverse_lerp(task_start_dec, task_end_dec, turn_timer.dec)
	remaining_turns = abs(task_end_turn - turn_timer.turn)

func accept_turn():
	if remaining_turns == 0:
		print('insert task functionality')
		queue_free()





