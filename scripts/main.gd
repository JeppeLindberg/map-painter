@tool
extends Node2D

var utils = preload("res://scripts/utils.gd").new()


func deselect_all():
	for node in utils.get_children_in_group(self, 'selectable'):
		node.deselect()
