extends Button

func _ready():
	text = name.substr(5)


func _on_Level_pressed():
	var path = "res://scene/level/{0}.tscn".format([name])
	SceneChanger.change_scene(path)