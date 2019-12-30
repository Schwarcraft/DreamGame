extends KinematicBody2D

export var speed = 150
export var maxHealth = 100

var health = maxHealth
var Mouse_position
#------Harvesting vars--------
var harvesting  = false

#-----Equipment vars-----
var is_equipped = false
var current_equipID = 0

slave var slave_position = Vector2()
slave var slave_rotation = 0
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	var GUI=preload("res://Source/GUI.tscn")
	var localGUI= GUI.instance()
	get_tree().get_root().add_child(localGUI)
	rpc('_unequip',1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _get_input():
	Mouse_position=get_local_mouse_position()
	
	if is_network_master():
		velocity = Vector2()
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
		#position += velocity * delta
		rotation += Mouse_position.angle()
#		position.x = clamp(position.x, 0, screen_size.x)
#		position.y = clamp(position.y, 0, screen_size.y)
		rset_unreliable("slave_position", position)
		rset_unreliable("slave_rotation", rotation)
		
		#-----Equipment Block-----
		if Input.is_action_just_pressed("equip"):
			if is_equipped== false:
				rpc('_equip',1)
				is_equipped = true 
			else:
				unequip(current_equipID)
			
			
		if Input.is_action_just_pressed("right_click"):
			get_node("AnimationPlayer").play("Spear_Attack")
		
		if Input.is_action_just_pressed("left_click"):
			harvesting = true;
			get_node("AnimationPlayer").play("Pickaxe_tex")
			harvesting = false;
		
		
				rpc('_unequip',1)
	else:
		position = slave_position
		rotation = slave_rotation
#Benjamins ADDED CODE to try and make collisions work
func _physics_process(delta):
	_get_input()
	move_and_collide(velocity * delta)

#This function will equip a set item:
#---Purpose---
#Will take an item ID (int) input and change the sprite of the equipment on the player
sync func _equip(id):
	var equipped
	match id:
		1: #ID 1= Spear
			$Spear.show()
			$Spear/Spear_Collider.disabled = false

			$Spear.set_process(true)

#			$Pickaxe_tex.show()

			current_equipID=1
	pass


sync func _unequip(id):
	match id:
		1: #ID 1 = Spear
			$Spear.hide()
			$Spear/Spear_Collider.disabled=true
			$Spear.set_process(false)



			current_equipID = 0
	is_equipped = false

	

remote func _hit(damage):
	health-= damage
	print("IM HIT!!!") 
	if health <= 0:
		health=0
		rpc('_die')


sync func _die():
	set_process(false)
	rpc('_unequip',current_equipID)
	position=Vector2(1000,1000)
#	hide()
	
