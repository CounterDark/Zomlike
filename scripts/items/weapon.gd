extends RigidBody2D
class_name Weapon

@export var attack_speed : float
var can_attack: bool = true

@onready var attack_timer : Timer = $WeaponTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func attack():
	if can_attack:
		attack_timer.start(attack_speed)
		can_attack = false

func _on_weapon_timer_timeout() -> void:
	can_attack = true

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		var attack_damage : int = round(PlayerStats.damage * (1.0 if randf() > PlayerStats.crit_chance else PlayerStats.crit_multiplier))
		if "hit" in body:
			body.hit(attack_damage)
