extends MarginContainer

var level

@export var level_text: RichTextLabel


func _process(_delta: float) -> void:
	level_text.text = str(level)
