extends CharacterBody2D

@export var default_speed: int = 400
@export var finding_speed: int = 300
@export var damage : int = 10
@export var stomp_damage : int = 20
@export var ranged_damage : int = 5
@export var crit_chance : float = 0.1
@export var crit_multiplier : float = 1.5
@export var bounce_multiplier : float = 3.0
@export var health: int = 2000

@onready var vurnerable_timer: Timer = $Timers/VurnerableTimer
@onready var attack_timer: Timer = $Timers/AttackTimer
@onready var walk_timer: Timer = $Timers/WalkTimer
@onready var move_timer: Timer = $Timers/MoveTimer

@onready var hit_player : AudioStreamPlayer2D = $HitPlayer
@onready var notice_player : AudioStreamPlayer2D = $NoticePlayer

@onready var stomp_animation : AnimationPlayer = $StompAnimation

@onready var navigation_agent: NavigationAgent2D = $ZombieBossNavigation

@onready var sprite : Sprite2D = $ZombieBossSprite
@onready var gun_sprite : Sprite2D = $ZombieWeapon

@onready var markers = $ZombieWeapon.get_children()


var can_attack : bool = false
var can_walk : bool = true
var enemy_nearby : bool = false
var vulnerable: bool = true
var collided: bool = true
var killed: bool = false

var stomp_radius: int = 200
var hit_animation_time : float = 0.10
var speed: int = default_speed

const rotation_border : float = 89.0

enum Moves {CHARGE, STOMP, SHOT, NONE}

var selected_move : Moves = Moves.NONE

func _ready() -> void:
	_change_stats()
	Difficulty.difficulty_change.connect(_on_difficulty_change)
	
func _physics_process(delta: float) -> void:
	var direction: Vector2
	if can_walk and enemy_nearby:
		if selected_move == Moves.CHARGE:
			print_debug("charge")
			direction = (Globals.player_position - position).normalized()
			velocity = direction * speed * delta
			
			var collision : KinematicCollision2D = move_and_collide(velocity)
			
			if collision:
				print_debug("Collision")
				var collision_direction = collision.get_normal()
				var reflect = collision.get_remainder().bounce(direction)
				velocity = velocity.bounce(collision.get_normal()) * speed * delta * bounce_multiplier
				move_and_collide(reflect)
				var collider : Object = collision.get_collider()
				if collider is Player:
					print_debug("Player collide")
					SignalBus.player_collided.emit(global_position, collision_direction)
					walk_timer.start()
					can_walk = false
	else:
		var next_path_pos: Vector2 = navigation_agent.get_next_path_position()
		direction = (next_path_pos - global_position).normalized()
		velocity = direction * finding_speed * delta
		move_and_collide(velocity)
		

func _process(_delta: float) -> void:
	if can_attack:
		print_debug("attack")
		if selected_move == Moves.SHOT:
			print_debug("shot")
			var selected_marker : Marker2D = markers[randi() % markers.size()]
			var current_direction : Vector2 = (Globals.player_position - markers[0].global_position).normalized()
			var angle : float = current_direction.angle()
			gun_sprite.rotation = angle
			var direction : Vector2 =  (Globals.player_position - markers[0].global_position).normalized()
			SignalBus.shot_zombie_bullet.emit(selected_marker.global_position, direction, round(ranged_damage * (1.0 if randf() > crit_chance else crit_multiplier)))
			attack_timer.start(0.1)
			can_attack = false
		elif selected_move == Moves.STOMP:
			print_debug("stomp")
			var in_range : bool = Globals.player_position.distance_to(global_position) < stomp_radius
			if in_range:
				PlayerStats.health -= round(stomp_damage * (1.0 if randf() > crit_chance else crit_multiplier))
			attack_timer.start(1.0)
			can_attack = false
	elif selected_move == Moves.STOMP:
		print_debug("stomp")
		can_attack = false
		stomp_animation.play("Stomp")
		
	if selected_move == Moves.NONE:
		selected_move = Moves[Moves.keys()[randi() % Moves.size()]]
		move_timer.start()
		can_attack = true
		can_walk = true
		
func stomp():
	can_attack = true
	can_walk = true

func hit(hit_damage : int, hit_direction: Vector2, knockback: int) -> void:
	if vulnerable:
		var new_position : Vector2 = position + hit_direction * knockback
		var current_position : Vector2 = position
		var tween = create_tween().bind_node(self)
		tween.tween_property(self, "position", new_position, hit_animation_time).from_current()
		tween.tween_property(self, "position", current_position, hit_animation_time).from(new_position)
		tween.play()
		hit_player.play()
		health -= hit_damage
		vulnerable = false
		vurnerable_timer.start()
		can_attack = false
		attack_timer.start()
		
	if health <= 0 and !killed:
		killed = true
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "modulate", Color.RED, 0.25)
		tween.tween_callback(self.queue_free)
		PlayerStats.kill_count += 1
		Globals.zabito_bossa = true

		
func _on_notice_area_body_entered(_body: Node2D) -> void:
	notice_player.play()
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
	navigation_agent.target_position = Globals.player_position

func _on_vurnerable_timer_timeout() -> void:
	vulnerable = true

func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_walk_timer_timeout() -> void:
	can_walk = true
	
func _on_move_timer_timeout() -> void:
	selected_move = Moves.NONE
	can_attack = false

func _on_difficulty_change() -> void:
	_change_stats()
	
func _change_stats() -> void:
	var stat_multiplier : float = Difficulty.get_stat_multiplier()
	health = round(health * stat_multiplier)
	damage = round(damage * stat_multiplier)
	stomp_damage = round(stomp_damage * stat_multiplier)
	ranged_damage = round(ranged_damage * stat_multiplier)


func _on_navigation_timer_timeout() -> void:
	if !enemy_nearby:
		navigation_agent.target_position = Globals.player_position
