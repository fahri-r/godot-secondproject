extends ProgressBar

onready var root = self.owner
onready var player = root.MainInstances.Player

func _ready():
	max_value = player.fire_timer.wait_time
	value = max_value


func _process(_delta):
	value = max_value - player.fire_timer.time_left
