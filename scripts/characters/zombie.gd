extends CharacterBody2D

@export var speed: int = 300
@export var finding_speed: int = 300
@export var damage : int = 10
@export var crit_chance : float = 0.05
@export var crit_multiplier : float = 1.5
@export var health: int = 30
@onready var navigation_agent: NavigationAgent2D = $ZombieNavigation
@onready var vurnerable_timer: Timer = $Timers/VurnerableTimer
@onready var attack_timer: Timer = $Timers/AttackTimer

var can_attack : bool = true
var enemy_nearby : bool = false
var vulnerable: bool = true

func _ready():
	navigation_agent.target_position = Globals.player_position
	

func _physics_process(delta: float) -> void:
	var direction: Vector2
	if !enemy_nearby:
		var next_path_pos: Vector2 = navigation_agent.get_next_path_position()
		direction = (next_path_pos - global_position).normalized()
		velocity = direction * finding_speed * delta
	else:
		direction = (Globals.player_position - position).normalized()
		velocity = direction * speed * delta
		
	var collision : KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)
		var collider : Object = collision.get_collider()
		if collider is Player:
			SignalBus.player_collided.emit(global_position, direction)


func hit(hit_damage : int):
	if vulnerable:
		health -= hit_damage
		vulnerable = false
		vurnerable_timer.start()
	if health <= 0:
		queue_free()

func _on_notice_area_body_entered(_body: Node2D) -> void:
	enemy_nearby = true

func _on_attack_area_body_entered(_body: Node2D) -> void:
	if can_attack:
		attack_timer.start()
		can_attack = false
		var attack_damage = damage * (1.0 if randf() > crit_chance else crit_multiplier)
		PlayerStats.health -= round(attack_damage)

func _on_attack_area_body_exited(_body: Node2D) -> void:
	can_attack = true

func _on_notice_area_body_exited(_body: Node2D) -> void:
	enemy_nearby = false

func _on_vurnerable_timer_timeout() -> void:
	vulnerable = true

func _on_attack_timer_timeout() -> void:
	can_attack = true


func _on_navigation_timer_timeout() -> void:
	navigation_agent.target_position = Globals.player_position
