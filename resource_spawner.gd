extends Node

var positionInArea = Vector2()
onready var spawn = preload("res://Source/Stone.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	_spawning()
	_spawning()
	_spawning()

func _spawning():
	
	positionInArea.x = (randi() % 100) - (100/2) + 50
	positionInArea.y = (randi() % 300) - (300/2) + 30
#	spawn = load("res://Source/Stone.gd").new()
	#print(str(spawn.position.x) + " ROCK X POSITION")
	var newRock=spawn.instance()
	newRock.position = positionInArea
	print("spawning rock here " + str(positionInArea.x) + "," +  str(positionInArea.y))
	get_tree().get_root().add_child(newRock)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
