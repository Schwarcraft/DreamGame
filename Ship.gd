extends RigidBody2D

var speed = 150
var rotation_speed = 150
var max_speed = 80
var screen_size
var Mouse_position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

slave var slave_position = Vector2()
slave var slave_rotation = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mouse_position=get_local_mouse_position()
	var velocity = Vector2()  # The player's movement vector.
	if is_network_master():
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		rotation += Mouse_position.angle()
#		position.x = clamp(position.x, 0, screen_size.x)
#		position.y = clamp(position.y, 0, screen_size.y)
		rset_unreliable("slave_position", position)
		rset_unreliable("slave_rotation", rotation)
	else:
		position = slave_position
		rotation = slave_rotation
			