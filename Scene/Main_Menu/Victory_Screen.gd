extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "The Winner is: " + Global.Winner

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.Winner = ""
	get_tree().change_scene_to_file("res://Scene/character_select/Char-select.tscn")
