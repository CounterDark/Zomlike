extends RigidBody2D

class_name Grenade

@export var speed: int = 750
@onready var destruct_timer : Timer = $DestructTimer
@onready var explosion_player : AnimationPlayer = $ExplosionPlayer

var explosion_active: bool = false
var explosion_radius: int = 400

var direction: Vector2 = Vector2.RIGHT

func get_direction() -> Vector2:
	var rotation_radians = deg_to_rad(rotation_degrees)
	return Vector2.RIGHT.rotated(rotation_radians)

func _ready() -> void:
	destruct_timer.start()

func explode()  -> void:
	explosion_player.play("Explode")
	explosion_active = true

func _process(_delta : float) -> void:
	if explosion_active:
		var attack_damage : int = round(PlayerStats.ranged_damage * (1.0 if randf() > PlayerStats.crit_chance else PlayerStats.crit_multiplier))
		for enemy in get_tree().get_nodes_in_group("Enemies"):
			var in_range = enemy.global_position.distance_to(global_position) < explosion_radius
			if "hit" in enemy and in_range:
				enemy.hit(attack_damage, get_direction(), 0)

func _on_destruct_timer_timeout() -> void:
	if !explosion_active:
		explode()

func _on_body_entered(_body: Node) -> void:
	explode()
