extends Node2D
var direction
var enemy1
var enemy2
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy1 = load("res://SBF-WIP/Scene/adventure/enemies/waddle_dee.tscn").instantiate()
	enemy1.position = Vector2(2000, 50)
	add_child(enemy1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	enemy1 = load("res://SBF-WIP/Scene/adventure/enemies/waddle_dee.tscn").instantiate()
	enemy1.position = Vector2(2000, 50)
	direction = -1
	add_child(enemy1)
	enemy2 = load("res://SBF-WIP/Scene/adventure/enemies/waddle_dee.tscn").instantiate()
	enemy2.position = Vector2(-2000, 50)
	direction = 1
	add_child(enemy2)
