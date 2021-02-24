extends CanvasLayer

signal scene_changed()

onready var animation = $AnimationPlayer
onready var timer = $Timer

func change_scene(path):
	if timer.is_stopped():
		timer.start()
		animation.play("fade")
	
	yield(animation, "animation_finished")
	get_tree().change_scene(path)
	
	if timer.is_stopped():
		timer.start()
		animation.play_backwards("fade")
	
	emit_signal("scene_changed")
