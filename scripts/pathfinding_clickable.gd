extends Node2D


var hovering = false
var callback_callable:Callable
var tile = Node2D


func left_click():
	callback_callable.call(self)

