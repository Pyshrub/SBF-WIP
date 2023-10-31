extends Node2D

var player1
var type = "wave"
# Called when the node enters the scene tree for the first time.
func _ready():
	player1 = load("res://SBF-WIP/Scene/fight/player_1.tscn").instantiate()
	player1.position = Vector2(0,0)
	add_child(player1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
