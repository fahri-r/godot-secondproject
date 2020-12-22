extends Node2D

onready var timer = $Timer
onready var animation_player = $AnimationPlayer
onready var sword_collision = $Sprite/DamageBox/CollisionShape2D

func _ready():
	set_process(false)


func _process(_delta):
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
