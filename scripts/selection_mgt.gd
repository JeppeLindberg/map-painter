extends Node

var utils = preload("res://scripts/utils.gd").new()

@onready var main = get_node('/root/main')


func deselect_all():
	for node in utils.get_children_in_group(main, 'selectable'):
		node.deselect()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("deselect"):
		deselect_all()

