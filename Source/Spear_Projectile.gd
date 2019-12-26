extends KinematicBody2D

var velocity = Vector2()
var speed = 500


func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)