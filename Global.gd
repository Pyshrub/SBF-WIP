extends Node
var play_one = ""
var play_two = ""
var P1_HP = get_hp("p1")
var P2_HP = get_hp("p2")
var P1_Max = 0
var P2_Max = 0
var Winner

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player1(check):
	if check == "Fail":
		print("check complete")
		play_one == check
		
func get_hp(player):
	if player == "p2":
		if play_two == "Fail":
			return 100
		elif play_two == "Sandy":
			print("hi")
			return 500
	if player == "p1" and play_one == "Fail":
		return 100
	else:
		print("you failed")
		return 100
	
func update_hp():
	var HUD = get_node_or_null("/root/fight/HUD")
	if HUD != null:
		HUD.update_health()
	
	if P1_HP <= 0:
		Winner = "Player 2"
		get_tree().change_scene_to_file("res://Scene/Main_Menu/victory_screen.tscn")
	elif P2_HP <= 0:
		Winner = "Player 1"
		get_tree().change_scene_to_file("res://Scene/Main_Menu/victory_screen.tscn")
