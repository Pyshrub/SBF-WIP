extends Control
@onready var source = get_parent()
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().paused = false
		self.hide()
	
func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.hide()

func _on_option_button_pressed() -> void:
	source.show_options()


func _on_mm_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/character_select/Char-select.tscn")
