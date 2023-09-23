extends Control

@onready var clouds = $Skybox
@onready var start = $title_screen/Label/startime
func _ready():
	clouds.play("title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#First hides all current elements, disabling them
	get_node("title_screen").hide()
	start.paused = true
	get_node("m_menu").show()


	
	
