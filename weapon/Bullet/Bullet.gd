extends Node2D

export (int) var bullet_speed = 90
var velocity = Vector2.ZERO

func _process(delta):
	position += velocity * delta


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()


func _on_DamageBox_area_entered(_area):
	queue_free()


func _on_DamageBox_body_entered(_body):
	queue_free()
