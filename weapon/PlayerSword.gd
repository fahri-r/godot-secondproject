extends "res://weapon/Weapon.gd"

const IDLE_DURATION = 0.25

export var move_to = Vector2.RIGHT
export var speed = 3.0

onready var sword = $Sprite
onready var sword_collision = $Sprite/DamageBox/CollisionShape2D
onready var tween = $Tween
onready var detector = $RayCast2D

var follow = Vector2.ZERO
var max_cast_to = Vector2(0, 21)
var cast_to = Vector2.ZERO

func _ready():
	cast_to = max_cast_to
	detector.set_cast_to(max_cast_to)


func _physics_process(_delta):
	set_weapon_range()
	check_weapon_attack()


func weapon_attack():
	var duration = move_to.length() / float(speed * 192)
	move_to.x = cast_to.y
	if move_to.x >= 5:
		tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
		tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration * IDLE_DURATION * 2)
		tween.start()


func set_weapon_range():
	if detector.is_colliding():
		cast_to.y -= 1
	elif !detector.is_colliding() and cast_to < max_cast_to:
		cast_to.y += 1
	detector.set_cast_to(cast_to)
	sword.position = sword.position.linear_interpolate(follow, 0.75)


func check_weapon_attack():
	if tween.is_active():
		sword_collision.disabled = false
	else:
		sword_collision.disabled = true
