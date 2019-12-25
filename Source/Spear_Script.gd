extends Area2D
export var Damage = 25

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var slave_position = Vector2()
var slave_rotation = 0
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if is_network_master():
		if Input.is_action_just_pressed("right_click"):
			get_node("../SpearPlayer").play("Spear_Attack")
			rset_unreliable("slave_position", position)
			rset_unreliable("slave_rotation", rotation)
	else:
		position = slave_position
		rotation = slave_rotation
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Spear_body_entered(body):
#	rset_unreliable(body.hide())
