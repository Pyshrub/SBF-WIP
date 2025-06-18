extends Control

@onready var clouds = $'Skybox'
@onready var start = $title_screen/Label/startime
@onready var musicfinder = $music_player
@onready var screenID = "Title"
func _ready():
	clouds.play("title")
	$music_player.volume_linear = Global.Music_Volume
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#First hides all current elements, disabling them
	get_node("title_screen").hide()
	start.paused = true
	get_node("m_menu").show()
func show_options():
	$Options.show()
