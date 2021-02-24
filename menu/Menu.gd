extends Control


func _on_About_pressed():
	SceneChanger.change_scene("res://menu/AboutMenu.tscn")


func _on_Control_pressed():
	SceneChanger.change_scene("res://menu/ControlMenu.tscn")


func _on_MainMenu_pressed():
	SceneChanger.change_scene("res://menu/MainMenu.tscn")


func _on_QuitGame_pressed():
	get_tree().quit()


func _on_NewGame_pressed():
	SceneChanger.change_scene("res://World.tscn")
