extends KinematicBody2D

export var throw_speed= 5
export var maxDamage=150 #If near center
export var minDamage=20 #If near edge of explosion

puppet var slave_position = Vector2()
var target =Vector2(0,0)
var is_thrown= false
var timerStarted = false
var bodiesInExplosion= null
onready var velocity = Vector2(throw_speed, 0).rotated(rotation)

func _physics_process(delta):
#	if is_network_master():
	if is_thrown && position.distance_to(target)>=10:
		var collision = move_and_collide(velocity)
		if collision:
			velocity=Vector2()
	
	if is_thrown && position.distance_to(target) <=30:
		$GrenadeCollider.disabled=false
		$ExplosionArea/ExplosionShape.disabled = false
#	rset_unreliable("slave_position", position)
#	else:
#		position=slave_position
		
	if is_thrown && !timerStarted:
		$ExplosionTimer.start()
		timerStarted=true
		print("Timer Started")

func _on_ExplosionTimer_timeout():
	$ExplosionArea/ExplosionShape.disabled = false # Replace with function body.
	bodiesInExplosion = $ExplosionArea.get_overlapping_bodies()
	for body in bodiesInExplosion:
		print(body.name)
		if body.has_method("_hit"):
			print("HIT")
			body.rpc("_hit",maxDamage)
			body._localHit(maxDamage)
	queue_free()

#remote func _setTarget(inputTarget):
#	target=inputTarget
#
#func _setTargetLocal(inputTarget):
#	target=inputTarget
