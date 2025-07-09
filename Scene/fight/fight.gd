extends Node2D
@onready var screenID = "StandardFight"
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player_Container.star()
	$music_player.volume_linear = Global.Music_Volume
	Global.Gamemode = "Standard"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("Menu") and get_tree().paused == false:
		get_tree().paused = true
		$Pause_Screen.show()
	elif Input.is_action_pressed("Menu"):
		print("help")
		
func show_pause():
	$Pause_Screen.show()
	$Pause_Screen/Resume.grab_focus()
func show_options():
	$Options.show()
