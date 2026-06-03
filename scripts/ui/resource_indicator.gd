extends PanelContainer


@export var wood_texture: Texture2D
@export var stone_texture: Texture2D
@export var manpower_texture: Texture2D

@export var texture: TextureRect
@export var resource_name: RichTextLabel
@export var gain_loss: RichTextLabel

@export var positive_color: Color
@export var neutral_color: Color
@export var negative_color: Color


func set_info(res_name, production):
	match res_name:
		'wood':
			resource_name.text = 'Wood'
			texture.texture = wood_texture
		'stone':
			resource_name.text = 'Stone'
			texture.texture = stone_texture
		'manpower':
			resource_name.text = 'Manpower'
			texture.texture = manpower_texture

	gain_loss.text = str(snapped(abs(production), 0.1))
	if production >= 0.0:
		gain_loss.text = '+' + gain_loss.text
	else:
		gain_loss.text = '-' + gain_loss.text

	if production > 0.0:
		gain_loss.self_modulate = positive_color
	elif production < 0.0:
		gain_loss.self_modulate = negative_color
	else:
		gain_loss.self_modulate = neutral_color
