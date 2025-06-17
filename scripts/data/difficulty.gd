extends Node

signal difficulty_change

var game_difficulty: int = 1

func get_stat_multiplier():
	if (game_difficulty == 0):
		return 0.5;
	elif (game_difficulty == 1):
		return 1.0;
	elif (game_difficulty == 2):
		return 2.0;
	else:
		return 1.0;
