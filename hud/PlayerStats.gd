extends ProgressBar

onready var root = self.owner
onready var player = root.MainInstances.Player

func _process(_delta):
	value = player.hp
