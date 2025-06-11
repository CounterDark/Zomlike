extends Node

signal stat_change

@export var max_health : int = 100
@export var base_attack_damage : int = 20
var attack_damage : int = base_attack_damage
var armor : int = 10
var player_invulnerable: bool = false

var health : int = 60:
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

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_invulnerable = false
