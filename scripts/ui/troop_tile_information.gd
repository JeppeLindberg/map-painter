extends MarginContainer

var tile = null


func _on_plus_pressed() -> void:
	tile.enqueue_task('build', 'troop')

func _on_minus_pressed() -> void:
	pass # Replace with function body.
