extends Node2D

const MISSILE = preload("res://weapon/Bullet/TankMissile.tscn")

export (int) var max_hp = 10
var hp = max_hp

var target = null
var target_position = Vector2.RIGHT

onready var gun = $Gun
onready var muzzle = $Gun/Position2D
onready var fire_timer = $FireTimer

func _process(_delta):
	if target:
			find_target()
			weapon_attack()


func find_target():
	target_position = (target.global_position - self.global_position).normalized()
	gun.rotation = target_position.angle()


func weapon_attack():
	yield(get_tree().create_timer(1.5),"timeout")
	if fire_timer.is_stopped():
		var main = get_tree().current_scene
		var missile = MISSILE.instance()
		main.add_child(missile)
		missile.global_position = muzzle.global_position
		missile.velocity = Vector2.RIGHT.rotated(gun.rotation) * missile.bullet_speed
		missile.rotation = missile.velocity.angle()
		fire_timer.start()


func _on_TargetDetector_body_entered(body):
	target = body


func _on_TargetDetector_body_exited(_body):
	target = null


func _on_HitBox_hit(damage):
	hp -= damage
