extends MarginContainer

@export var task_text: RichTextLabel
@export var countup: Control

var task = null

func _process(_delta: float) -> void:
	if task != null:
		task_text.text = task.text
		countup.visible = true
	else:
		task_text.text = '...'
		countup.visible = false

func clear():
	task = null
