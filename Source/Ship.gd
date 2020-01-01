extends KinematicBody2D

export var speed = 150
export var maxHealth = 100

var health = maxHealth
var Mouse_position
var networkID
#------Harvesting vars--------
var harvesting  = false

#-----Equipment vars-----
var current_equipID = 0

#------------------------
#---  Equipment List  ---
#------------------------
var spearHeldScene = preload("res://Source/Equipment/Spear_Held.tscn")
var spearHeld = null #1

onready var pickaxeScene = preload("res://Source/Equipment/Pickaxe.tscn")
var pickaxe = null #2

onready var hatchetScene = preload("res://Source/Equipment/Hatchet.tscn")
var hatchet = null #3



#Network Stuff
slave var slave_position = Vector2()
slave var slave_rotation = 0
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_network_master():
		var GUI=preload("res://Source/GUI.tscn")
		var localGUI= GUI.instance()
		get_tree().get_root().add_child(localGUI)

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
		if Input.is_action_just_pressed("equip1"):
			if current_equipID != 1:
				rpc('_unequip', current_equipID)
				rpc('_equip',1)
				current_equipID=1

		if Input.is_action_just_pressed("equip2"):
			if current_equipID != 2:
				rpc('_unequip', current_equipID)
				rpc('_equip',2)
				current_equipID=2
		
		if Input.is_action_just_pressed("equip3"):
			if current_equipID != 3:
				rpc('_unequip', current_equipID)
				rpc('_equip',3)
				current_equipID=3

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
	match id:
		1: #ID 1= Spear
			spearHeld=spearHeldScene.instance()
			spearHeld.set_network_master(networkID)
			add_child(spearHeld)
		2: #ID 2= Pickaxe
			pickaxe=pickaxeScene.instance()
			pickaxe.set_network_master(networkID)
			add_child(pickaxe)
		3: #ID 3 = hatchet
			hatchet = hatchetScene.instance()
			hatchet.set_network_master(networkID)
			add_child(hatchet)
			
	pass


sync func _unequip(id):
	match id:
		1: #ID 1 = Spear
			remove_child(spearHeld)
			
		2: #ID 2 = Pickaxe
			remove_child(pickaxe)
		3: #ID 3 = Hatchet
			remove_child(hatchet)
	current_equipID=0
	

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
	
