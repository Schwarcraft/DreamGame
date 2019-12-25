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
			rpc('_Animate')

sync func _Animate():
	get_node("../AnimationPlayer").play("Spear_Attack")


func _on_Spear_body_entered(body):
	if body.has_method("_hit"):
		body.rpc('_hit',Damage)
	
