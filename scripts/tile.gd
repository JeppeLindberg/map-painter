@tool
extends Node2D

var utils = preload("res://scripts/utils.gd").new()

@onready var tiles = get_parent()

var tile_index:Vector2i

var color = 'neutral'

@export var surface_polygon: Polygon2D
@export var colorizable_polygon: Polygon2D

@export var polygon: PackedVector2Array


func initialize():
	var points = []
	for point in polygon:
		points.append(point)

	points.sort_custom(ccw_sort)

	colorizable_polygon.polygon = PackedVector2Array(points)
	surface_polygon.polygon = PackedVector2Array(utils.shrink_polygon(points, 4.0, 0.5))

func ccw_sort(a, b):
	var angle_a = Vector2.UP.angle_to(a)
	var angle_b = Vector2.UP.angle_to(b)

	return angle_a > angle_b


func _ready() -> void:
	if Engine.is_editor_hint():
		return

	initialize()

func get_relative_tile(vec):
	return tiles.get_tile(tile_index + vec)

func get_color():
	return color

func paint(new_color):
	color = new_color

func get_current_occupant():
	var occupants = utils.get_children_in_group(self, 'occupant')
	if occupants == []:
		return null
	else:
		return occupants[0]

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	match color:
		'neutral':
			pass
			# visual_neutral.visible = true
			# visual_player.visible = false
			# visual_enemy.visible = false
		'player':
			pass
			# visual_neutral.visible = false
			# visual_player.visible = true
			# visual_enemy.visible = false
		'enemy':
			pass
			# visual_neutral.visible = false
			# visual_player.visible = false
			# visual_enemy.visible = true

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


