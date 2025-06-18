extends Control
@onready var old_music_volume = Global.Music_Volume
var new_music_volume
var music_max
var music_min
@onready var parent = get_parent()
@onready var source = get_parent().get_node_or_null("music_player")

func _ready():
	$Volume_Slider.value = old_music_volume
	


func _on_volume_slider_value_changed(value: float) -> void:
	new_music_volume = value
	source.volume_linear = new_music_volume
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		self.hide()
		if get_parent().screenID == "Title":
			get_parent().get_tree().paused = false
			print("resumed")
		elif get_parent().screenID == "StandardFight":
			parent.show_Pause()

func _on_apply_settings_pressed() -> void:
	Global.Music_Volume = new_music_volume




func _on_return_pressed() -> void:
	self.hide()
	print("hidden")
	if get_parent().screenID == "Title":
		get_parent().get_tree().paused = false
		print("resumed")
	elif get_parent().screenID == "StandardFight":
		parent.show_pause()
