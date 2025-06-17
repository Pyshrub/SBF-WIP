extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player_Container.star()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("res://Scene/character_select/Char-select.tscn")
