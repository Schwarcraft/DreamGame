extends RigidBody2D

var speed = 150
var Mouse_position

#-----Equipment vars-----
var is_equipped = false
var current_equipID = 0


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
			if is_equipped== false:
				rpc('equip',1)
				is_equipped = true 
			else:
				rpc('unequip',1)
			
			

		
		
		
	else:
		position = slave_position
		rotation = slave_rotation


#This function will equip a set item:
#---Purpose---
#Will take an item ID (int) input and change the sprite of the equipment on the player
sync func equip(id):
	var equipped
	match id:
		1: #ID 1= Spear
			$Spear.show()
			$Spear.set_process(true)
			current_equipID=1
	pass


sync func unequip(id):
	match id:
		1: #ID 1 = Spear
			$Spear.hide()
			$Spear.set_process(false)
			current_equipID = 0
	is_equipped = false
	



