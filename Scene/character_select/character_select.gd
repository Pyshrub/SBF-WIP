extends Control
var p_1_clicks = 0
var p_2_clicks = 0
var fight = load("res://Scene/fight/fight.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if p_1_clicks == 1 and p_2_clicks == 1:
		if Global.play_two != "":
			get_tree().change_scene_to_file("res://Scene/fight/fight.tscn")
			p_1_clicks = 0
			p_2_clicks = 0
		else:
			pass
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("res://Scene/T_Screen/control.tscn")

	

func _on_fail_pressed():
	Global.play_one = "Fail"
	Global.P1_Max = 100
	p_1_clicks = 1

	



func _on_fail_mouse_entered():
	if p_1_clicks == 0:
		$Fail_Preview.show()


func _on_fail_mouse_exited():
	if p_1_clicks == 0:
		$Fail_Preview.hide()
		
func _on_fail_2_pressed():
	Global.play_two = "Fail"
	Global.P2_Max = 100
	p_2_clicks = 1


func _on_sandy_pressed():
	Global.play_two = "Sandy"
	Global.P2_Max = 500
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
