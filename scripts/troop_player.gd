extends Troop

@export var pathfinding_clickable_prefab: PackedScene
@export var soldier_count: RichTextLabel

var utils = preload("res://scripts/utils.gd").new()

var selected = false

@export var main_color: Color
@export var secondary_color: Color


func _ready() -> void:
	super._ready()
	add_to_group('troop_player')
	faction = 'blue'

func _process(_delta: float) -> void:
	if get_tile().get_faction() != 'blue':
		get_tile().paint('blue')

	soldier_count.text = str(get_number_of_soldiers())

func commit_turn():
	super.commit_turn()

	update()

@onready var prev_update = {
	'selected': selected,
	'tile': get_tile(),
	'state': state
}

func update():
	_local_update()

	prev_update = {
		'selected': selected,
		'tile': get_tile(),
		'state': state
	}

func _local_update():
	if selected and not prev_update['selected']:
		create_pathfinding_clickables()
		return

	if not selected and prev_update['selected']:
		delete_pathfinding_clickables()
		return

	if selected and prev_update['tile'] != get_tile():
		create_pathfinding_clickables()
		return

var pathfinding_clickables = []

func create_pathfinding_clickables():
	delete_pathfinding_clickables()

	for tile in get_tile().get_tiles_explore(10):
		var pathfinding_clickable = pathfinding_clickable_prefab.instantiate()
		tile.add_child(pathfinding_clickable)
		pathfinding_clickable.position = Vector2.ZERO
		pathfinding_clickable.callback_callable = pathfinding_clickable_clicked
		pathfinding_clickable.tile = tile
		pathfinding_clickables.append(pathfinding_clickable)
		

func pathfinding_clickable_clicked(caller):
	target_tile = caller.tile
	if state != 'battle':
		go_to_move_to_state()

func delete_pathfinding_clickables():
	for i in range(len( pathfinding_clickables) - 1, -1 ,-1):
		pathfinding_clickables[i].queue_free()
		pathfinding_clickables.remove_at(i)

func select():
	selected = true
	update()

func deselect():
	selected = false
	update()

func _on_panel_pressed() -> void:
	unit_clicked()
