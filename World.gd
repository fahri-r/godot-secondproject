extends Node2D

const MainInstances = preload("res://MainInstances.tres")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_World_tree_exiting():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
