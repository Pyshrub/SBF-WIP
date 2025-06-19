extends Node2D
# Called when the node enters the scene tree for the first time.
const DialogueSettings = preload("res://addons/dialogue_manager/settings.gd")
@onready var resource: DialogueResource = load(DialogueSettings.get_user_value("run_resource_path"))
func _ready():
	Global.Gamemode = "wave"
	DialogueManager.show_dialogue_balloon(resource, "start")
	pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("res://Scene/character_select/Char-select.tscn")
func pause():
	get_tree().paused = true
func unpause():
	get_tree().paused = false
