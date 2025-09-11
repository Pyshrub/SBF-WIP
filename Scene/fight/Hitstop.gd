extends Node

func hit_stop(length):
	Engine.time_scale = 0
	await get_tree().create_timer(length, true, false, true).timeout
	Engine.time_scale = 1

func slow_mo(length):
	Engine.time_scale = 0.5
	await get_tree().create_timer(length, true, false, true).timeout
	Engine.time_scale = 1
