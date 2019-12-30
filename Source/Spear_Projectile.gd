extends KinematicBody2D

var velocity = Vector2()
#has_hit Defines if this object has hit something hit. This is used to prevent damaging multiple times
var has_hit = false
export var speed = 5
export var damage= 1

func _physics_process(delta):
		velocity = Vector2(speed, 0).rotated(rotation)
		var collision = move_and_collide(velocity)
		if collision:
			if collision.collider.has_method("_hit") and has_hit==false:
				collision.collider.rpc("_hit",damage)
				has_hit=true
				free()