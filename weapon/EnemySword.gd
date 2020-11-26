extends Node2D

onready var timer = $Timer
onready var animation_player = $AnimationPlayer

func _ready():
	set_process(false)


func _process(_delta):
	var parent = get_parent()
	rotation = parent.target_position.angle()
	
	if timer.is_stopped():
		animation_player.play("attack")
		timer.start()
