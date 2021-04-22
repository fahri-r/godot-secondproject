extends CanvasLayer

signal scene_changed()

onready var animation = $AnimationPlayer

func change_scene(path, level="0"):
	animation.play("fade")
	
	yield(animation, "animation_finished")
	
	if path:
		get_tree().change_scene(path)
	
	if level != "0":
		yield(get_tree().create_timer(0.5),"timeout")
		change_level(level)
	
	animation.play_backwards("fade")
	
	emit_signal("scene_changed")


func change_level(level):
	var prev_level = int(level) - 1
	prev_level = "Level{0}".format([prev_level])
	
	level = "Level{0}".format([level])
	
	var level_scene = load("res://scene/level/{0}.tscn".format([level])).instance()
	var world = get_tree().current_scene
	world.add_child(level_scene)
	world.move_child(level_scene, 1)
	world.get_node("Player").global_position = world.get_node("{0}/SpawnPosition".format([level])).global_position
	
	if world.has_node(prev_level):
		world.get_node(prev_level).queue_free()
