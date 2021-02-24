extends Control

const LEVELBUTTON = preload("res://menu/LevelButton.tscn")


func _ready():
	add_button()


func add_button() -> void:
	var total_level = count_level("res://scene/level/")
	var button_for = 1
	
	while button_for <= total_level:
		var levelbutton = LEVELBUTTON.instance()
		levelbutton.name = "Level{0}".format([button_for])
		get_node("CenterContainer/GridContainer").add_child(levelbutton, true)
		button_for += 1


func count_level(scan_dir : String):
	var total_level = 0
	var dir := Directory.new()
	
	if dir.open(scan_dir) != OK:
		printerr("Warning: could not open directory: ", scan_dir)
		return []
	
	if dir.list_dir_begin(true, true) != OK:
		printerr("Warning: could not list contents of: ", scan_dir)
		return []
	var file_name := dir.get_next()
	while file_name != "":
		total_level += 1
		file_name = dir.get_next()
	
	return total_level
