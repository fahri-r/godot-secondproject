extends Node2D

onready var timer = $Timer
onready var animation_player = $AnimationPlayer
onready var sword_collision = $Sprite/DamageBox/CollisionShape2D
onready var sprite = $Sprite

func _ready():
	get_parent().connect("enemy_died", self, "on_enemy_died")
	get_parent().connect("enemy_ready", self, "on_enemy_ready")


func _process(_delta):
	if get_parent().target:
		check_weapon_attack()
		weapon_rotation()
		weapon_attack()


func weapon_rotation():
	var parent = get_parent()
	rotation = parent.target_position.angle()


func weapon_attack():
	if timer.is_stopped():
		animation_player.play("attack")
		timer.start()


func check_weapon_attack():
	if animation_player.is_playing():
		sword_collision.disabled = false
	else:
		sword_collision.disabled = true


func on_enemy_died():
	sprite.material = null


func on_enemy_ready(material):
	sprite.material = material
