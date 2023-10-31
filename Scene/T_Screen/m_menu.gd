extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fight_pressed():
	print("yes")
	get_tree().change_scene_to_file("res://SBF-WIP/Scene/character_select/Char-select.tscn")



func _on_texture_button_3_pressed():
	get_tree().change_scene_to_file("res://SBF-WIP/Scene/adventure/Wave_Battle.tscn")
