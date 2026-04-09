extends PanelContainer

@export var resource_prefab: PackedScene

@export var resources_container: Control

@onready var resource_mgt = get_node('/root/main/resource_mgt')


var resources_information_state = []

func _process(_delta):
	var new_resources_information_state = []

	for resource in ['ducats', 'manpower']:
		new_resources_information_state.append({
			'faction': 'blue',
			'resource': resource,
			'amount': resource_mgt.get_resource('blue', resource)
		})
	
	if new_resources_information_state != resources_information_state:
		resources_information_state = new_resources_information_state

		for child in resources_container.get_children():
			child.queue_free()

		for state in resources_information_state:
			var new_resource_info = resource_prefab.instantiate()
			resources_container.add_child(new_resource_info)
			new_resource_info.set_amount(state['resource'], state['amount'])
			
			
