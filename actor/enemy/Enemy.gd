extends Actor

export (int) var max_hp = 10
var hp = max_hp

var target_position = Vector2.RIGHT
var target = null

onready var animation = $AnimationPlayer
onready var sword = $Sword
onready var floor_detector = $Sprite/FloorDetector
onready var sprite = $Sprite
onready var visibility_notifier = $VisibilityNotifier2D

func _ready():
	MAXSPEED = 20


func find_target():
	if target:
		target_position = (target.global_position - self.global_position).normalized()
		
		if target.motion.y != 0:
			yield(get_tree().create_timer(0.2), "timeout")
			jump()


func get_input_vector():
	var input_vector = Vector2.ZERO
	if target and floor_detector.is_colliding():
		input_vector.x = sign(target_position.x)
	else:
		input_vector.x = 0
	return input_vector


func set_horizontal_motion(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)


func set_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)


func update_snap():
	if is_on_floor():
		snap = Vector2.DOWN


func jump():
	if is_on_floor():
		motion.y = -JUMPFORCE
		snap = Vector2.ZERO


func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMPFORCE)


func apply_movement():
	motion = move_and_slide_with_snap(motion, snap * 4, Vector2.UP, true, 4, deg2rad(MAXSLOPEANGLE))


func update_facing():
	sprite.scale.x = sign(target_position.x)

func died():
	if hp <= 0:
		jump()
		set_collision_layer_bit(4, false)
		set_collision_mask_bit(3, false)
		
		if !visibility_notifier.is_on_screen():
			queue_free()


func _on_PlayerDetector_body_entered(body):
	target = body
	sword.set_process(true)


func _on_PlayerDetector_body_exited(_body):
	target = null
	sword.set_process(false)


func _on_HitBox_hit(damage):
	hp -= damage
