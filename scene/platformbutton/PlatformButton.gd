extends Area2D

onready var sprite = $Sprite

signal pressed
signal unpressed


func _on_Area2D_body_entered(_body):
	sprite.visible = false
	emit_signal("pressed")


func _on_Area2D_body_exited(_body):
	sprite.visible = true
	emit_signal("unpressed")
