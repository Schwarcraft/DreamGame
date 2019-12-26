extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the se for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HostButton_pressed():
	ConnectionManager.on_host_game()


func _on_JoinButton_pressed():
	var ip = $Panel/ColorRect/TextEdit.text	
	ConnectionManager.on_join_game(ip)

