extends CharacterBody2D
class_name Player

@export var max_speed: float = 400
@export var min_speed: float = 40
@export var collision_speed: float = 1200

@onready var reduced_speed_timer : Timer = $Timers/ReducedSpeedTimer
@onready var collision_timer : Timer = $Timers/CollisionTimer

var collided : bool = false
var can_collide : bool = true

var equipped_weapon : Weapon

var speed: float = max_speed :
	set(value):
		if value < speed:
			speed = max(value, min_speed)
		else:
			speed = min(value, max_speed)
		

func _ready() -> void:
	SignalBus.player_collided.connect(_on_player_collided)
	#_equip_weapon(preload("res://Scenes/items/sword.tscn"))
	_equip_weapon(preload("res://Scenes/items/assault_rifle.tscn"))

func _equip_weapon(weapon_packed_scene: Resource) -> void:
	var weapon : Node = weapon_packed_scene.instantiate()
	if weapon is Weapon:
		equipped_weapon = weapon
		self.add_child(weapon)
	
func _unequip_weapon() -> void:
	if equipped_weapon != null:
		equipped_weapon.queue_free()
		equipped_weapon = null

func _process(_delta: float) -> void:
	if equipped_weapon != null:
		if Input.is_action_pressed("primary action"):
			equipped_weapon.attack()
	if PlayerStats.health <= 0 :
		get_tree().change_scene_to_file("res://Scenes/main_menu/MainMenu.tscn")


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
