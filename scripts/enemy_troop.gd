extends Node2D


var target_tile = null

@export var intent_arrow: Node2D

@export var soldier_count: RichTextLabel

@export var soldiers: Node

var morale = 100.0
var broken = 100.0

@export var main_color: Color
@export var secondary_color: Color


func _ready() -> void:
	add_to_group('troop')
	add_to_group('enemy_troop')

func _process(_delta):
	if get_tile().get_faction() != 'red':
		get_tile().paint('red')

	soldier_count.text = str(get_number_of_soldiers())

func commit_turn():
	pass
	
func get_tile():
	return get_parent().get_parent()


func get_number_of_soldiers():
	return soldiers.get_child_count()
