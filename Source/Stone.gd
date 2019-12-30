extends StaticBody2D
var HP = 100
#export(int) var _stone_to_give

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_harvested():
	print("Harvesting")
	HP -= 25

func _yield_resource():

	var gui = get_node("/root/GUI_NODE/GUI")
	#var gui = preload("res://Source/GUI.tscn")


	gui._add_stone()
	get_parent().remove_child(self)

	#GIVE STONE TO RESOURCE MANAGER
	
func _process(delta):
	if HP <= 0:
		#emit_signal("yield_resource")
		_yield_resource()

#SPAWNING

	
	
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
