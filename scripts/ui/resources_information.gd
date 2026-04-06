extends PanelContainer

@export var resource_prefab: PackedScene

@export var resources_container: Control

@onready var faction_mgt = get_node('/root/main/faction_mgt')


var resources_information_state = []

func _process(_delta):
	var new_resources_information_state = []

	for resource in ['stone']:
		new_resources_information_state.append({
			'faction': 'blue',
			'resource': 'stone',
			'amount': faction_mgt.get_resource('blue', 'stone')
		})
	
	if new_resources_information_state != resources_information_state:
		resources_information_state = new_resources_information_state

		for child in resources_container.get_children():
			child.queue_free()

		for state in resources_information_state:
			var new_resource_info = resource_prefab.instantiate()
			




