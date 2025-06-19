extends Node

signal stat_change

@export var max_health : int = 100
@export var base_damage : int = 5
@export var base_crit_chance : float = 0.1
@export var crit_multiplier: float = 1.5
@export var base_armor : int = 10

const INVURNERABLE_TIME : float = 0.4

var player_invulnerable: bool = false

var time_start : float = 0

var time_played : float = 0

var kill_count : int = 0

var damage : int = base_damage:
	set(value):
		damage = base_damage + value
		
var armor : int = base_armor:
	set(value):
		armor = base_armor + value
		
var crit_chance : float = base_crit_chance:
	set(value):
		crit_chance = base_crit_chance + value
		
var ranged_damage : int = 0

var health : int = max_health:
	set(value):
		if value > health:
			health = min(value, max_health)
		else:
			if !player_invulnerable:
				health = value - armor
				player_invulnerable = true
				player_invulnerable_timer()
		stat_change.emit()

var health_kit_amount : int = 5:
	set(value):
		health_kit_amount = value
		stat_change.emit()

func player_invulnerable_timer() -> void :
	await get_tree().create_timer(INVURNERABLE_TIME).timeout
	player_invulnerable = false
