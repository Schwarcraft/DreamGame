extends KinematicBody2D

var velocity = Vector2()
#has_hit Defines if this object has hit something hit. This is used to prevent damaging multiple times
var has_hit = false
export var speed = 5
export var damage=25


func _physics_process(delta):
#	if has_hit !=false:
		velocity = Vector2(speed, 0).rotated(rotation)
		var collision = move_and_collide(velocity)
		if collision:
			print(collision.collider.name)
			has_hit=true
			if collision.collider.has_method("_hit"):
				collision.collider.rpc("_hit",damage)
				print("HIT YOU")
				free()
			else:
				free()
#	else:
#		velocity=Vector2(0,0)