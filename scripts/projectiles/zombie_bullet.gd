extends Area2D

class_name ZombieBullet

@export var speed: int = 1000

var attack_damage: int = 0

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
	if body is Player:
		PlayerStats.health -= attack_damage
	queue_free()


func _on_destruct_timer_timeout() -> void:
	queue_free()
