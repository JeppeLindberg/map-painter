@tool
extends StaticBody2D

var utils = preload("res://scripts/utils.gd").new()

@onready var selection_mgt = null
@onready var tiles = get_parent()

var tile_index:Vector2i

var color = 'neutral'

@export var surface_polygon: Polygon2D
@export var colorizable_polygon: Polygon2D
@export var overlay_polygon: Polygon2D
@export var shape: CollisionPolygon2D

@export_storage var neighbour_paths = []
@export_storage var polygon: PackedVector2Array

@export var neutral_color: Color
@export var player_color: Color
@export var enemy_color: Color

var hovering = false



func _ready() -> void:
	create_visual()

	if Engine.is_editor_hint():
		return

	if selection_mgt == null:
		selection_mgt = get_node('/root/main/selection_mgt')
	connect('mouse_entered', _on_mouse_entered)
	connect('mouse_exited', _on_mouse_exited)

func create_visual():
	var points = []
	for point in polygon:
		points.append(point)
	if len(points) == 0:
		return

	points.sort_custom(ccw_sort)

	colorizable_polygon.polygon = PackedVector2Array(points)
	overlay_polygon.polygon = PackedVector2Array(points)
	surface_polygon.polygon = PackedVector2Array(utils.shrink_polygon(points, 2.0, 0.5))
	shape.polygon = PackedVector2Array(points)

func ccw_sort(a, b):
	var angle_a = Vector2.UP.angle_to(a)
	var angle_b = Vector2.UP.angle_to(b)

	return angle_a > angle_b

func calculate_neighbours():
	neighbour_paths = []

	var global_points = []
	for point in polygon:
		global_points.append(point + global_position)

	for tile in get_parent().get_children():
		if tile.is_queued_for_deletion():
			continue
		if tile == self:
			continue

		var other_global_points = []
		for point in tile.polygon:
			other_global_points.append(point + tile.global_position)
		
		var add_neighbour = false
		if contained_in(global_points[0], other_global_points) and contained_in(global_points[len(global_points) - 1], other_global_points):
			add_neighbour = true

		if not add_neighbour:
			for i in range(len(global_points) - 1):
				if contained_in(global_points[i], other_global_points) and contained_in(global_points[i+1], other_global_points):
					add_neighbour = true
		
		if add_neighbour:
			neighbour_paths.append(self.get_path_to(tile))


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
		neutral_color = colorizable_polygon.color
		return

	overlay_polygon.visible = hovering

	match color:
		'neutral':
			colorizable_polygon.color = neutral_color
		'player':
			colorizable_polygon.color = player_color
		'enemy':
			colorizable_polygon.color = enemy_color

func get_neighbours():
	var neighbour_nodes = []
	for path in neighbour_paths:
		neighbour_nodes.append(get_node(path))
	return neighbour_nodes

func get_step_toward(target_tile):
	if target_tile == null:
		return null

	var path = tiles.get_tile_path(self, target_tile)
	if len(path) < 2:
		return null

	return path[1]
	

func get_tiles_explore(distance):
	var explored_tiles = tiles.get_tile_explore_distance(self, distance)
	explored_tiles.erase(self)
	return explored_tiles


func contained_in(vec, vec_array):
	for v in vec_array:
		if v.distance_to(vec) < 1.0:
			return true
	return false


func _on_mouse_entered() -> void:
	hovering = true

func _on_mouse_exited() -> void:
	hovering = false

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed and hovering:
			var clickable_clicked = false
			for child in get_children():
				if child.has_method('left_click'):
					clickable_clicked = true
					child.left_click()

			if not clickable_clicked:
				selection_mgt.tile_clicked(self)
