extends Control
var clicks = 0
var fight = load("res://SBF-WIP/Scene/fight/fight.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	

func _on_fail_pressed():
	if clicks == 0:
		Global.play_one = "Fail"
		clicks += 1
	elif clicks == 1:
		Global.play_two = "Fail"
		clicks += 1
		if clicks == 2:
			get_tree().change_scene_to_file("res://SBF-WIP/Scene/fight/fight.tscn")
			clicks = 0
	



func _on_fail_mouse_entered():
	if clicks == 0:
		$Fail_Preview.show()


func _on_fail_mouse_exited():
	if clicks == 0:
		$Fail_Preview.hide()
		



func _on_sandy_pressed():
	if clicks == 0:
		Global.play_one = "Fail"
		clicks += 1
	elif clicks == 1:
		Global.play_two = "Sandy"
		clicks += 1
		if clicks == 2:
			get_tree().change_scene_to_file("res://SBF-WIP/Scene/fight/fight.tscn")
			clicks = 0
	


func _on_sandy_mouse_entered():
	$Sandy_Preview.show()

func _on_sandy_mouse_exited():
	$Sandy_Preview.hide()
