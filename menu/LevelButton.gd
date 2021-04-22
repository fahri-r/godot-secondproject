extends Button

func _ready():
	text = name.substr(5)


func _on_Level_pressed():
	SceneChanger.change_scene("res://World.tscn", text)
