extends Node2D

onready var animated_sprite = $AnimatedSprite
onready var particle = $Particles2D
onready var area = $Area2D


func _ready():
	var button = get_tree().current_scene.find_node("PlatformButton",true,false)
	button.connect("pressed", self, "on_pressed")
	button.connect("unpressed", self, "on_unpressed")


func on_pressed():
	animated_sprite.play("open")
	particle.set_self_modulate(Color(1, 1, 1, 1))
	area.set_monitoring(true)


func on_unpressed():
	animated_sprite.play("open", true)
	particle.set_self_modulate(Color(1, 1, 1, 0))
	area.set_monitoring(false)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var next_level = get_parent().name.substr(5)
		next_level = int(next_level) + 1
		SceneChanger.change_scene(false,str(next_level))
