extends Control
var pressed = false

func _ready():
	$Back_Button.grab_focus()
func _on_streaming_stage_button_pressed() -> void:
	pressed = true
	Global.Selected_Stage = "Streaming"
	$Fight_Button.show()
func _on_not_dennys_button_pressed() -> void:
	pressed = true
	Global.Selected_Stage = "Dennys"
	$Fight_Button.show()
	
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		if pressed == false:
			get_tree().change_scene_to_file("res://Scene/character_select/Char-select.tscn")
		else:
			pressed = false
			$Fight_Button.hide()
	

func _on_fight_button_pressed() -> void:
	print(Global.Selected_Stage)
