extends CharacterBody2D
class_name Player

@export var max_speed: float = 400
@export var min_speed: float = 40
@export var collision_speed: float = 1200

@onready var reduced_speed_timer : Timer = $Timers/ReducedSpeedTimer
@onready var collision_timer : Timer = $Timers/CollisionTimer

var collided : bool = false
var can_collide : bool = true

var equipped_weapon_id:
	get():
		return PlayerInventory.get_equiped_id()
		
var equipped_weapon: Weapon = null

var speed: float = max_speed :
	set(value):
		if value < speed:
			speed = max(value, min_speed)
		else:
			speed = min(value, max_speed)
		

func _ready() -> void:
	SignalBus.player_collided.connect(_on_player_collided)
	PlayerInventory.weapon_changed.connect(_on_weapon_change)

func _process(_delta: float) -> void:
	
	if equipped_weapon != null:
		if Input.is_action_pressed("primary action"):
			equipped_weapon.attack()
	if PlayerStats.health <= 0 :
		PlayerStats.health = PlayerStats.max_health
		get_tree().change_scene_to_file("res://Scenes/main_menu/MainMenu.tscn")
		PlayerStats.reset()
	

func _physics_process(_delta: float) -> void:
	if collided:
		collided = false
	else:
		var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
		velocity = direction * speed
		Globals.player_direction = direction
	move_and_slide()
	Globals.player_position = global_position

func _on_player_collided(_position : Vector2, collision_direction : Vector2):
	if can_collide :
		collided = true
		can_collide = false
		speed -= 50
		collision_timer.start()
		reduced_speed_timer.start()
		collision_direction = -1 * collision_direction
		velocity = collision_speed * collision_direction
		Globals.player_direction = collision_direction

func _on_reduced_speed_timer_timeout() -> void:
	speed = max_speed

func _on_collision_timer_timeout() -> void:
	can_collide = true

func _on_weapon_change() -> void:
	var new_weapon = PlayerInventory.get_equiped_node()
	if new_weapon:
		equipped_weapon = new_weapon
		self.add_child(equipped_weapon)
	else:
		self.remove_child(equipped_weapon)
