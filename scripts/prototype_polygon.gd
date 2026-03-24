@tool
extends Polygon2D


var prev_points = []

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
					print(points[i])
					for other_point in other_polygon_points:
						if (points[i] + global_position).distance_to(other_point) < 10.0:
							polygon[i] = other_point - global_position
							points[i] = other_point - global_position
							break				
					break

		prev_points = points


func get_other_poly_points():
	var result = []
	for child in get_parent().get_children():
		if child != self:
			for point in child.polygon:
				result.append(point + child.global_position)

	return result
