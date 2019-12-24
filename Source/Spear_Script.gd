extends KinematicBody2D

var is_equipped
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		get_node("../SpearPlayer").play("Spear_Attack")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
