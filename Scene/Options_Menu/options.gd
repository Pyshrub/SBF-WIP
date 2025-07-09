extends Control
@onready var old_music_volume = Global.Music_Volume
var new_music_volume
var music_max
var music_min
var save_settings = false
@onready var parent = get_parent()
@onready var source = get_parent().get_node_or_null("music_player")
var old_screen_state
var new_screen_state
var fullscreen

func _ready():
	$Options_container/Options_buttons_container/Volume_Slider.value = old_music_volume
	old_screen_state = DisplayServer.window_get_mode()
	print(old_screen_state)
	new_music_volume = $Options_container/Options_buttons_container/Volume_Slider.value
	if old_screen_state == 0:
		$Options_container/Options_buttons_container/CheckButton.button_pressed = false
	else:
		$Options_container/Options_buttons_container/CheckButton.button_pressed = true

func _on_volume_slider_value_changed(value: float) -> void:
	new_music_volume = value
	source.volume_linear = new_music_volume
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		settings_restore()
		self.hide()
		if get_parent().screenID == "Title":
			get_parent().get_tree().paused = false
			print("resumed")
		elif get_parent().screenID == "StandardFight":
			parent.show_Pause()
		

func _on_apply_settings_pressed() -> void:
	#using a boolean to check if settings were saved would make changes after the save always take effect
	#setting the old to the new allows this to change
	Global.Music_Volume = new_music_volume
	old_music_volume = new_music_volume
	old_screen_state = new_screen_state


func  settings_restore():
	if save_settings == false:
		#resets sound settings to before changes
		source.volume_linear = old_music_volume
		$Options_container/Options_buttons_container/Volume_Slider.value = old_music_volume
		#resets display to before changes
		DisplayServer.window_set_mode(old_screen_state)
		if old_screen_state == 0:
			$Options_container/Options_buttons_container/CheckButton.button_pressed = false
		else:
			$Options_container/Options_buttons_container/CheckButton.button_pressed = true
	else:
		pass
		


func _on_return_pressed() -> void:
	settings_restore()
	self.hide()
	print("hidden")
	if get_parent().screenID == "Title":
		get_parent().get_tree().paused = false
		print("resumed")
	elif get_parent().screenID == "StandardFight":
		parent.show_pause()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		new_screen_state = DisplayServer.window_get_mode()
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false
		new_screen_state = DisplayServer.window_get_mode()


func _on_visibility_changed() -> void:
	if visible:
		$"Main Buttons/Apply_Settings".grab_focus()
