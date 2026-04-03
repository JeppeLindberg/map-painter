extends MarginContainer

@export var task_text: RichTextLabel
@export var countup: Control

@onready var turn_timer = get_node('/root/main/camera/turn_timer')

var task = null

func _process(_delta: float) -> void:
	if task != null:
		task_text.text = task.get_text()
		countup.visible = true
		countup.progress = task.progress
		countup.remaining_turns = task.remaining_turns
	else:
		task_text.text = '...'
		countup.visible = false

func clear():
	task = null
