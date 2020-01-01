extends Node2D

#Range that can be thrown
export var throw_range = 100
var playerPosition = Vector2()

var in_Range = false

func _process(_delta):
	position=get_global_mouse_position()
	if (playerPosition.distance_to(position)) > throw_range:
		$Sprite.modulate = Color(1, 1, 1) # default
		in_Range = false
	else:
		$Sprite.modulate = Color(0, 0, 1) # blue
		in_Range = true