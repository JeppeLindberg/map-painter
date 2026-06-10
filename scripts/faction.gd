extends Node

@export var faction_name = 'blue'

var ducats = 1.0
var manpower = 1.0


func add_resource(resource_name, amount):
	if resource_name == 'ducats':
		ducats += amount
	if resource_name == 'manpower':
		manpower += amount


func get_resource(resource_name):
	if resource_name == 'ducats':
		return ducats
	if resource_name == 'manpower':
		return manpower

