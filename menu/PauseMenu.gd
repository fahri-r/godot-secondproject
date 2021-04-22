extends Control

var game_over = false
onready var world = get_tree().current_scene
onready var title = $CenterContainer2/Panel/Label
onready var restart_button = $CenterContainer2/Panel/VBoxContainer/RestartLevel
onready var resume_button = $CenterContainer2/Panel/VBoxContainer/ResumeGame


func _ready():
	world.get_node("Player").connect("died", self, "on_player_died")


func mouse_mode():
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func on_player_died():
	game_over = true
	title.text = "Game Over"
	
	restart_button.visible = true
	resume_button.visible = false
	
	var new_pause_state = ! get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	mouse_mode()


func _input(event):
	if event.is_action_pressed("pause") and game_over == false:
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


func _on_RestartLevel_pressed():
	var level = get_tree().get_nodes_in_group("level")[0].name.substr(5)
	SceneChanger.change_scene("res://World.tscn", level)
	get_tree().paused = false
