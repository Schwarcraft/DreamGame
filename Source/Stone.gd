extends StaticBody2D
var gui = load("res://Source/GUI.gd").new()
var HP = 100
export(int) var _stone_to_give

signal yield_resource
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_harvested():
	print("Harvesting")
	HP -= 25

func _yield_resource():
	var gui = get_parent().get_node("GUI_NODE/GUI")
	gui._add_stone()
	get_parent().remove_child(self)

	#GIVE STONE TO RESOURCE MANAGER
	
func _process(delta):
	if HP <= 0:
		emit_signal("yield_resource")
		_yield_resource()
		
	
	
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
