extends Actor
class_name Box


var body = null


func _ready():
	set_physics_process(false)


func _physics_process(delta):
	if body:
		var push = get_input()
		if push:
			var vector = get_input_vector()
			set_horizontal_motion(vector, delta)
			apply_gravity(delta)
			apply_movement()


func get_input():
	if Input.is_action_just_pressed("push"):
		if not body.is_push:
			body.is_push = true
		elif body.is_push:
			body.is_push = false
	return body.is_push


func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return input_vector


func set_horizontal_motion(input_vector: Vector2, delta) -> void:
	motion.x = input_vector.x * ACCELERATION * delta * BOX_SPEED_SCALE


func apply_gravity(delta) -> void:
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMPFORCE)


func apply_movement() -> void:
	move_and_slide(motion, Vector2())


func _on_Area2D_body_entered(body):
	self.body = body
	set_physics_process(true)


func _on_Area2D_body_exited(body):
	body.is_push = false
	self.body = null
	set_physics_process(false)
