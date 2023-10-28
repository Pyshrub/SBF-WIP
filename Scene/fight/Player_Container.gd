extends Node2D
var player1
var player2
func ready():
	pass
func star():
	print("we")
	if Global.play_one == "Fail":
		player1 = load("res://SBF-WIP/Scene/fight/player_1.tscn").instantiate()
	add_child(player1)
	if Global.play_two == "Fail":
		player2 = load("res://SBF-WIP/Scene/fight/fail_2.tscn").instantiate()
		player2.position = Vector2(900,0)
	elif Global.play_two == "Sandy":
		player2 = load("res://SBF-WIP/Scene/character_select/Characters/sandy.tscn").instantiate()
		player2.position = Vector2(900,0)
	add_child(player2)
