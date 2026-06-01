extends Troop


@export var intent_arrow: Node2D

@export var soldier_count: RichTextLabel

@export var main_color: Color
@export var secondary_color: Color


func _ready() -> void:
	super._ready()
	add_to_group('troop_enemy')
	faction = 'red'

func _process(_delta):
	if get_tile().get_faction() != 'red':
		get_tile().paint('red')

	soldier_count.text = str(get_number_of_soldiers())

func commit_turn():
	super.commit_turn()
