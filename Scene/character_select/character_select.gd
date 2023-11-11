extends Control
var p_1_clicks = 0
var p_2_clicks = 0
var fight = load("res://SBF-WIP/Scene/fight/fight.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if p_1_clicks == 1 and p_2_clicks == 1:
		get_tree().change_scene_to_file("res://SBF-WIP/Scene/fight/fight.tscn")
		p_1_clicks = 0
		p_2_clicks = 0

	

func _on_fail_pressed():
	Global.play_one = "Fail"
	p_1_clicks += 1

	



func _on_fail_mouse_entered():
	if p_1_clicks == 0:
		$Fail_Preview.show()


func _on_fail_mouse_exited():
	if p_1_clicks == 0:
		$Fail_Preview.hide()
		
func _on_fail_2_pressed():
	Global.play_two = "Fail"
	p_2_clicks = 1


func _on_sandy_pressed():
	Global.play_two = "Sandy"
	p_2_clicks = 1


func _on_sandy_mouse_entered():
	if p_2_clicks == 0:
		$Sandy_Preview.show()

func _on_sandy_mouse_exited():
	if p_2_clicks == 0:
		$Sandy_Preview.hide()




func _on_fail_2_mouse_entered():
	if p_2_clicks == 0:
		$Fail_Preview2.show()

func _on_fail_2_mouse_exited():
	if p_2_clicks == 0:
		$Fail_Preview2.hide()
