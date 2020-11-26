extends ProgressBar

onready var enemy = get_parent()

func _ready():
	max_value = enemy.max_hp
	value = max_value


func _process(_delta):
	value = enemy.hp
