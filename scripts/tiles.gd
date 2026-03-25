@tool
extends Node

const X_RESOLUTION = 54
const Y_RESOLUTION = 54

var tiles_dict = {}
var initialized = false

var utils = preload("res://scripts/utils.gd").new()

@export var tile_prefab: PackedScene
@export var tile_polygon_prefab: PackedScene
@export var occupant_container: Node2D
@export var tiles_prototype: Node2D


@export_tool_button("Recreate", "Callable") var recreate_callable = recreate
@export_tool_button("Clear", "Callable") var clear_callable = clear

func clear():
	for occupant in utils.get_children_in_group(self, 'occupant'):
		occupant.reparent(occupant_container)

	for child in get_children():
		child.queue_free()

	tiles_prototype.visible = true

func recreate():	
	clear()

	for tile_prototype in tiles_prototype.get_children():
		var avg_global_point = Vector2.ZERO
		for point in tile_prototype.polygon:
			avg_global_point += point + tile_prototype.global_position
		avg_global_point /= len(tile_prototype.polygon)

		var new_tile = tile_polygon_prefab.instantiate()
		add_child(new_tile)
		new_tile.owner = get_tree().edited_scene_root
		new_tile.global_position = avg_global_point
		
		var new_points = []
		for point in tile_prototype.polygon:
			new_points.append(point - (avg_global_point - tile_prototype.global_position))

		new_tile.polygon = PackedVector2Array(new_points)
		
	for tile in get_children():
		if tile.is_queued_for_deletion():
			continue

		tile.create_visual()

	for tile in get_children():
		if tile.is_queued_for_deletion():
			continue

		tile.calculate_neighbours()
		
		for child in occupant_container.get_children():
			if child.global_position == tile.global_position:
				child.reparent(tile)

	tiles_prototype.visible = false

func _process(_delta) -> void:
	if Engine.is_editor_hint():
		return

func get_tile(vector_index):
	if vector_index in tiles_dict:
		return tiles_dict[vector_index]
	return null

func get_tile_path(from_tile, to_tile):
	if from_tile == null or to_tile == null:
		return []

	var frontier = [{
		'node': from_tile,
		'index_from': null
	}]
	var explored_tiles = []

	while len(frontier) > 0:
		for i in range(len(frontier)-1,-1,-1):
			for neighbour in frontier[i]['node'].get_neighbours():
				var add_neighbour = true
				for pair in (frontier + explored_tiles):
					if pair['node'] == neighbour:
						add_neighbour = false

				if add_neighbour:
					frontier.append({
						'node': neighbour,
						'index_from': len(explored_tiles)
					})
					
			explored_tiles.append({
				'node': frontier[i]['node'],
				'index_from': frontier[i]['index_from']
			})
			
			if explored_tiles[len(explored_tiles) - 1]['node'] == to_tile:
				return retread_path(from_tile, explored_tiles)

			frontier.remove_at(i)
	
	return []

func retread_path(from_tile, explored_tiles):
	var result = []
	
	var index = len(explored_tiles) - 1
	while true:
		result.append(explored_tiles[index]['node'])
		index = explored_tiles[index]['index_from']

		if result[len(result) - 1] == from_tile:
			break

	result.reverse()
	return result

func get_tile_explore_distance(from_tile, distance):
	if from_tile == null:
		return []

	var frontier = [{
		'node': from_tile,
		'index_from': null,
		'distance': 0
	}]
	var explored_tiles = []

	while len(frontier) > 0:
		for i in range(len(frontier)-1,-1,-1):
			for neighbour in frontier[i]['node'].get_neighbours():
				var add_neighbour = true
				for pair in (frontier + explored_tiles):
					if pair['node'] == neighbour:
						add_neighbour = false

				var new_distance = 1
				if frontier[i]['index_from'] != null:
					new_distance = explored_tiles[frontier[i]['index_from']]['distance'] + 1
					if new_distance > distance:
						add_neighbour = false

				if add_neighbour:
					frontier.append({
						'node': neighbour,
						'index_from': len(explored_tiles),
						'distance': new_distance
					})
					
			explored_tiles.append({
				'node': frontier[i]['node'],
				'index_from': frontier[i]['index_from'],
				'distance': frontier[i]['distance'],
			})

			frontier.remove_at(i)

	return all_nodes(explored_tiles)

func all_nodes(explored_tiles):
	var result = []
	for pair in explored_tiles:
		result.append(pair['node'])
	return result
