extends Control

func mouse_mode():
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = ! get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
	
	mouse_mode()


func _on_MainMenu_pressed():
	SceneChanger.change_scene("res://menu/MainMenu.tscn")
	get_tree().paused = false


func _on_SelectLevel_pressed():
	SceneChanger.change_scene("res://menu/SelectLevelMenu.tscn")
	get_tree().paused = false


func _on_ResumeGame_pressed():
	var new_pause_state = ! get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	mouse_mode()
