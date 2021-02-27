extends Actor

const MISSILE = preload("res://weapon/Bullet/PlayerMissile.tscn")
const GUN = preload("res://weapon/Gun.tscn")
const SWORD = preload("res://weapon/PlayerSword.tscn")
const MainInstances = preload("res://MainInstances.tres")

export (int) var max_hp = 100
var hp = max_hp
var is_push = false

onready var weapon_position = $WeaponPosition
onready var sprite = $Sprite
onready var fire_timer = $FireTimer
onready var animation = $AnimationPlayer

func _ready():
	MainInstances.Player = self
	MAXSPEED = 64


func _exit_tree():
	MainInstances.Player = null


func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return input_vector


func set_horizontal_motion(input_vector, delta):
	if input_vector.x != 0:
		if not is_push:
			motion.x += input_vector.x * ACCELERATION * delta
		elif is_push:
			motion.x = input_vector.x * ACCELERATION * delta * BOX_SPEED_SCALE
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)


func set_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)


func update_snap():
	if is_on_floor():
		snap = Vector2.DOWN


func jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump") and not is_push:
			motion.y = -JUMPFORCE
			snap = Vector2.ZERO


func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMPFORCE)


func apply_movement():
	motion = move_and_slide_with_snap(motion, snap * 4, Vector2.UP, true, 4, deg2rad(MAXSLOPEANGLE))


func update_facing():
	var facing = sign(get_local_mouse_position().x)
	if facing != 0:
		sprite.scale.x = facing


func change_weapon():
	if Input.is_action_just_released("gun"):
		if sprite.has_node("Sword"):
			sprite.get_node("Sword").queue_free()
		
		if !sprite.has_node("Gun"):
			var gun = GUN.instance()
			sprite.add_child(gun)
			gun.global_position = weapon_position.global_position
	
	if Input.is_action_just_released("sword"):
		if sprite.has_node("Gun"):
			sprite.get_node("Gun").queue_free()
		
		if !sprite.has_node("Sword"):
			var sword = SWORD.instance()
			sprite.add_child(sword)
			sword.global_position = weapon_position.global_position


func weapon_attack():
	if Input.is_action_just_pressed("attack") and not is_push:
		if sprite.has_node("Sword"):
			sprite.get_node("Sword").weapon_attack()
			
		elif sprite.has_node("Gun"):
			if fire_timer.is_stopped():
				var main = get_tree().current_scene
				var missile = MISSILE.instance()
				main.add_child(missile)
				missile.global_position = sprite.get_node("Gun").muzzle.global_position
				missile.velocity = Vector2.RIGHT.rotated(sprite.get_node("Gun").rotation) * missile.bullet_speed
				missile.velocity.x *= sprite.scale.x
				missile.rotation = missile.velocity.angle()
				fire_timer.start()


func check_push():
	if is_push:
		if sprite.has_node("Sword"):
			sprite.get_node("Sword").visible = false
		elif sprite.has_node("Gun"):
			sprite.get_node("Gun").visible = false
	elif not is_push:
		if sprite.has_node("Sword"):
			sprite.get_node("Sword").visible = true
		elif sprite.has_node("Gun"):
			sprite.get_node("Gun").visible = true


func _on_HitBox_hit(damage):
	hp -= damage
