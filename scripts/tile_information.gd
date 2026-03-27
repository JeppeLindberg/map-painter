@tool
extends Panel

@export var text_label: RichTextLabel

@export_range(0.0,1.0) var expand_pct = 1.0

var text = ''
var open = false


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if open:
			expand_pct = min(expand_pct + (delta * 2.0), 1.0)
		else:
			expand_pct = max(expand_pct - (delta * 2.0), 0.0)
			
		text_label.text = text

	custom_minimum_size.y = get_parent().size.y * expand_pct
