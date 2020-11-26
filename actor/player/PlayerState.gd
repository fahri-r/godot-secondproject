extends StateMachine

var input_vector = Vector2.ZERO

func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)


func _state_logic(delta):
	input_vector = parent.get_input_vector()
	parent.set_horizontal_motion(input_vector, delta)
	parent.set_friction(input_vector)
	parent.update_snap()
	parent.jump()
	parent.apply_gravity(delta)
	parent.apply_movement()
	parent.update_facing()
	parent.change_weapon()
	parent.weapon_attack()


func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					return states.jump
				elif parent.motion.y > 0:
					return states.fall
			elif input_vector.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					return states.jump
				elif parent.motion.y > 0:
					return states.fall
			elif input_vector.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.motion.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.motion.y < 0:
				return states.jump
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animation.play("idle")
		states.run:
			parent.animation.play("run")
		states.jump:
			parent.animation.play("jump")
