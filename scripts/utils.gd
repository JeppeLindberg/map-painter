
var _result

func get_children_in_group(node, group):
    _result = []

    _get_children_in_group_recursive(node, group)

    return _result

func _get_children_in_group_recursive(node, group):
    for child in node.get_children():
        if child.is_queued_for_deletion():
            continue

        if group == '' or child.is_in_group(group):
            _result.append(child)

        _get_children_in_group_recursive(child, group)

func shrink_polygon(vertices, distance, vertical_mult):
    var n = len(vertices)
    var new_vertices = []

    for i in range(n):
        var prev = vertices[(i - 1 + n) % n]
        var curr = vertices[i]
        var next = vertices[(i + 1) % n]

        # Step 1: Compute edge directions
        var edge1 = normalize(curr - prev)
        var edge2 = normalize(next - curr)

        # Step 2: Compute inward normals (for CCW polygon)
        var normal1 = perpendicular(edge1) * -1
        var normal2 = perpendicular(edge2) * -1

        # Step 3: Offset the two edges
        # Line1: passes through curr + normal1 * d, direction edge1
        # Line2: passes through curr + normal2 * d, direction edge2

        var p1 = curr + (normal1* Vector2(1.0,vertical_mult)) * distance
        var dir1 = edge1

        var p2 = curr + (normal2* Vector2(1.0,vertical_mult)) * distance
        var dir2 = edge2 

        # Step 4: Find intersection of the two offset lines
        var new_point = intersect_lines(p1, dir1, p2, dir2)

        new_vertices.append(new_point)

    return new_vertices

func normalize(v):
    return v / v.length()

func perpendicular(v):
    return Vector2(-v.y, v.x)  # 90° rotation

func intersect_lines(p1, d1, p2, d2):
    # Solve: p1 + t*d1 = p2 + u*d2

    var cross = cross_2d(d1, d2)

    if abs(cross) < 0.01:
        return null  # parallel lines (edge case)

    var t = cross_2d(p2 - p1, d2) / cross
    return p1 + d1 * t

func cross_2d(a, b):
    return a.x * b.y - a.y * b.x
