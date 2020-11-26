extends Area2D

export(int) var damage = 1

func _on_DamageBox_area_entered(hitbox):
	if hitbox.name == "HitBox":
		hitbox.emit_signal("hit", damage)
