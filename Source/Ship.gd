extends RigidBody2D



var speed = 150


var Mouse_position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

slave var slave_position = Vector2()
slave var slave_rotation = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mouse_position=get_local_mouse_position()
	var velocity = Vector2()  # The player's movement vector.
	if is_network_master():
		
		#-----Movement Block-----
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		rotation += Mouse_position.angle()
#		position.x = clamp(position.x, 0, screen_size.x)
#		position.y = clamp(position.y, 0, screen_size.y)
		rset_unreliable("slave_position", position)
		rset_unreliable("slave_rotation", rotation)
		
		#-----Equipment Block-----
		if Input.is_action_just_pressed("equip"):
			equip(1)
			
		if Input.is_action_just_pressed("right_click"):
			get_node("AnimationPlayer").play("Spear_Attack")
		
		
		
	else:
		position = slave_position
		rotation = slave_rotation


#This function will equip a set item:
#---Purpose---
#Will take an item ID (int) input and change the sprite of the equipment on the player

func equip(id):
	var equipped
	match id:
		1: #ID 1= Spear
			$Spear_tex.show()
	pass


