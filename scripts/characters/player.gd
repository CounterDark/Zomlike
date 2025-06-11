extends CharacterBody2D


@export var max_speed: float = 400
@export var min_speed: float = 40

var equipped_weapon : Weapon

var current_speed: float = max_speed :
	set(value):
		if value < current_speed:
			current_speed = min(value, min_speed)
		else:
			current_speed = min(value, max_speed)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerStats.health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * current_speed
	rotation = direction.angle()
	move_and_slide()
	Globals.player_position = global_position
	
	if Input.is_action_pressed("primary action"):
		equipped_weapon.attack()


	
