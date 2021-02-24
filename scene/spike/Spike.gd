extends Node2D

var is_hide = true

onready var timer = $Timer
onready var animation_player = $AnimationPlayer

func _process(_delta):
	if timer.is_stopped():
		if is_hide:
			animation_player.play_backwards("hide")
			is_hide = false
		
		elif not is_hide:
			animation_player.play("hide")
			is_hide = true
		
		timer.start()
