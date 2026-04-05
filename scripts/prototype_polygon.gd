@tool
extends Polygon2D

var prev_points = []

@export_enum('stone') var resource = 'stone'
@export_enum('neutral', 'blue', 'red') var faction = 'neutral'

@export var default_barracks_level:int = 0


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return

	var points = []
	points.append_array(polygon)

	if points != prev_points:
		if len(points) == len(prev_points):
			var other_polygon_points = get_other_poly_points()

			for i in range(len(points)):
				if points[i] != prev_points[i]:
					for other_point in other_polygon_points:
						if (points[i] + global_position).distance_to(other_point) < 10.0:
							polygon[i] = other_point - global_position
							points[i] = other_point - global_position
							break				
					break

		prev_points = points

	match faction:
		'neutral':
			self_modulate = Color.WHITE
		'blue':
			self_modulate = Color.AQUAMARINE
		'red':
			self_modulate = Color.ROSY_BROWN


func get_other_poly_points():
	var result = []
	for child in get_parent().get_children():
		if child != self:
			for point in child.polygon:
				result.append(point + child.global_position)

	return result
