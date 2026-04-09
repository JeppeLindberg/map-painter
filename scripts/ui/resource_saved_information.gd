extends PanelContainer

@export var amount_label: RichTextLabel

@export_enum('ducats', 'manpower') var resource_name = 'ducats'

@export var ducats_texture: Texture
@export var manpower_texture: Texture

@export var texture_control: TextureRect


func set_amount(new_resource_name, amount):
	resource_name = new_resource_name

	match resource_name:
		'ducats':
			texture_control.texture = ducats_texture
		'manpower':
			texture_control.texture = manpower_texture

	amount_label.text = str(snapped(amount, 0.1))


