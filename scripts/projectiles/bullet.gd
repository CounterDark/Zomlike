extends Area2D

class_name Bullet

@export var speed: int = 1000

var knockback : int = 0

@onready var destruct_timer : Timer = $DestructTimer

var direction: Vector2 = Vector2.RIGHT

func get_direction() -> Vector2:
		var rotation_radians = deg_to_rad(rotation_degrees)
		return Vector2.RIGHT.rotated(rotation_radians)

func _ready() -> void:
	destruct_timer.start()

func _process(delta : float) -> void:
	position += direction * speed * delta

func _on_body_entered(body : Node2D) -> void:
	var attack_damage : int = round(PlayerStats.ranged_damage * (1.0 if randf() > PlayerStats.crit_chance else PlayerStats.crit_multiplier))
	if body.is_in_group("Enemies") and "hit" in body:
		body.hit(attack_damage, get_direction(), knockback)
	queue_free()


func _on_destruct_timer_timeout() -> void:
	queue_free()
