extends MarginContainer

@export var building_name = ''
var tile = null

@onready var selection_mgt = get_node('/root/main/selection_mgt')

@export var level_text: RichTextLabel

func _ready():
	add_to_group(building_name)

func _process(_delta: float) -> void:
	var level = tile.get_building_level('barracks')
	level_text.text = str(level)

func _on_plus_pressed() -> void:
		tile.enqueue_task('upgrade', 'barracks')

func _on_minus_pressed() -> void:
	print('minus')
