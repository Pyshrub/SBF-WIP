extends Control

var fight = load("res://SBF-WIP/Scene/fight/fight.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	

func _on_fail_pressed():
	get_tree().change_scene_to_file("res://SBF-WIP/Scene/fight/fight.tscn")
	



func _on_fail_mouse_entered():
	
	$Fail_Preview.show()


func _on_fail_mouse_exited():
	$Fail_Preview.hide()
