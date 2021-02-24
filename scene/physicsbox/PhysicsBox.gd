extends Actor
class_name Box

const SPEED_SCALE = 2.5


func push(input_vector: Vector2, delta) -> void:
	var velocity = Vector2.ZERO 
	velocity.x = ACCELERATION * input_vector.x * delta * SPEED_SCALE
	move_and_slide(velocity, Vector2())
