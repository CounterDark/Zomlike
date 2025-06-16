extends CharacterBody2D
class_name Player

@export var max_speed: float = 400
@export var min_speed: float = 40

@onready var reduced_speed_timer : Timer = $Timers/ReducedSpeedTimer
@onready var collision_timer : Timer = $Timers/CollisionTimer

var collided : bool = false
var equipped_weapon : Weapon

var speed: float = max_speed :
	set(value):
		if value < speed:
			speed = min(value, min_speed)
		else:
			speed = min(value, max_speed)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerStats.health = 100
	SignalBus.player_collided.connect(_on_player_collided)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("primary action"):
		if equipped_weapon != null:
			equipped_weapon.attack()

func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_position = global_position
	Globals.player_direction = direction

func _on_player_collided(_position : Vector2, collision_direction : Vector2):
	if !collided :
		collided = true
		speed -= 50
		collision_timer.start()
		reduced_speed_timer.start()


func _on_reduced_speed_timer_timeout() -> void:
	speed = max_speed


func _on_collision_timer_timeout() -> void:
	collided = false
