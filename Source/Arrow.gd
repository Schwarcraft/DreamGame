extends Sprite

func _process(_delta):
	if Input.is_action_pressed("left_click") && scale.y <=3.0:
		scale.y+=0.02
		
