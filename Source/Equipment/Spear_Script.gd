extends Area2D
export var Damage = 25

onready var spear_projectile_scene = preload("res://Source/Equipment/Spear_Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if is_network_master():
		
		#-----Standard Attack-----
		if Input.is_action_just_pressed("left_click"):
			rpc('_Animate')
		
		#-----Thrown Attack-----
		if Input.is_action_just_pressed("right_click"):
			rpc('_throwSpear')


sync func _Animate():
	get_node("AnimationPlayer").play("Attack")


#-----Throws the a spear by creating a new projectile node in the current scene
sync func _throwSpear():
	var ship_node = get_parent()
	var projectile = spear_projectile_scene.instance()
	projectile.position=ship_node.position
	projectile.rotation=ship_node.rotation
	get_tree().get_root().add_child(projectile)
	ship_node._unequip(1)


func _on_Spear_body_entered(body):
	if body.has_method("_hit"):
		body.rpc('_hit',Damage)
	
