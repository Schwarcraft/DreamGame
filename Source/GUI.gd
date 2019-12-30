extends Node
var stone_count = 0
onready var stone_label = $HBoxContainer/Counters/Counter/Background/Number


# Called when the node enters the scene tree for the first time.
func _ready():
	stone_label.text = str(stone_count)
	pass # Replace with function body.

func _add_stone():
	stone_count +=1
	stone_label.text = str(stone_count)
#func _process(delta):
#	pass
