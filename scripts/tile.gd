extends Node2D

@onready var tiles = get_parent()
@onready var main = get_node('/root/main')

var tile_index:Vector2i

var color = 'neutral'

@export var visual_neutral: Node2D
@export var visual_player: Node2D
@export var visual_enemy: Node2D



func get_relative_tile(vec):
	return tiles.get_tile(tile_index + vec)

func get_color():
	return color

func paint(new_color):
	color = new_color

func get_current_occupant():
	var occupants = main.get_children_in_group(self, 'occupants')
	if occupants == []:
		return null
	else:
		return occupants[0]

func _process(_delta: float) -> void:
	match color:
		'neutral':
			visual_neutral.visible = true
			visual_player.visible = false
			visual_enemy.visible = false
		'player':
			visual_neutral.visible = false
			visual_player.visible = true
			visual_enemy.visible = false
		'enemy':
			visual_neutral.visible = false
			visual_player.visible = false
			visual_enemy.visible = true

func get_neighbours():
	var result = []	
	for vec in [Vector2i.UP,Vector2i.DOWN,Vector2i.LEFT,Vector2i.RIGHT]:
		var other_tile = get_parent().get_tile(tile_index + vec)
		if other_tile != null:
			result.append(other_tile)
	
	return result

func get_step_toward(target_tile_index):
	if target_tile_index == null:
		return null

	var path = tiles.get_tile_path(tile_index, target_tile_index)
	if len(path) < 2:
		return null

	return path[1]
	

func get_tiles_explore(distance):
	var explored_tiles = tiles.get_tile_explore_distance(tile_index, distance)
	explored_tiles.erase(self)
	return explored_tiles


