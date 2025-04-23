extends Node2D
var player1
var player2
var type = "Normal"
func ready():
	pass
func star():
	if Global.play_one == "Fail":
		player1 = load("res://Scene/fight/player_1.tscn").instantiate()
		player1.player_num = 1
		player1.hp = player1.max_hp
	add_child(player1)
	if Global.play_two == "Fail":
		player2 = load("res://Scene/fight/player_1.tscn").instantiate()
		player2.player_num = 2
		player2.position = Vector2(900,0)
		player2.hp = player2.max_hp
	elif Global.play_two == "Sandy":
		player2 = load("res://Scene/character_select/Characters/sandy.tscn").instantiate()
		player2.position = Vector2(900,0)
	add_child(player2)
