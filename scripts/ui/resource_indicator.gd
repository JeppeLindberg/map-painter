extends PanelContainer


@export var resource_name: RichTextLabel
@export var gain_loss: RichTextLabel

@export var positive_color: Color
@export var neutral_color: Color
@export var negative_color: Color


func set_info(res_name, production):
	match res_name:
		'stone':
			resource_name.text = 'Stone'
		'lead':
			resource_name.text = 'Lead'

	gain_loss.text = str(snapped(production, 0.1))
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
