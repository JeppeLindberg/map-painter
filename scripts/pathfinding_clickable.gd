extends StaticBody2D


var hovering = false
var callback_callable:Callable
var tile_index = Vector2i.ZERO



func _on_mouse_entered() -> void:
	hovering = true


func _on_mouse_exited() -> void:
	hovering = false


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.pressed and hovering:
			callback_callable.call(self)

