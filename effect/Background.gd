extends Sprite

func _process(delta):
	position = get_parent().get_node("Player").position
