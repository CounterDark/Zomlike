extends Node

signal difficulty_change

var game_difficulty: int = 1:
	get():
		return game_difficulty
	set(value):
		game_difficulty = value
