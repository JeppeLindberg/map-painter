extends PanelContainer

@export var amount_label: RichTextLabel


func set_amount(amount):
	amount_label.text = str(snapped(amount, 0.1))
