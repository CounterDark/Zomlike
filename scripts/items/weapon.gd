extends RigidBody2D
class_name Weapon

@export var item_id : String

@export var attack_speed : float
@export var weapon_attack_damage : int
@export var weapon_range_damage : int
@export var weapon_crit_chance : float
@export var knockback : int

var can_attack: bool = true
const rotation_border : float = 89.0

@onready var attack_timer : Timer = $WeaponTimer

func _ready() -> void:
	PlayerStats.damage = weapon_attack_damage
	PlayerStats.crit_chance = weapon_crit_chance
	PlayerStats.ranged_damage = weapon_range_damage

func _physics_process(_delta: float) -> void:
	self.global_position = Globals.player_position
	self.rotation = Globals.player_direction.angle()
	scale.y = absf(scale.y) * (1.0 if absf(rotation_degrees) < rotation_border else -1.0)

func _on_tree_exiting() -> void:
	PlayerStats.damage -= weapon_attack_damage
	PlayerStats.crit_chance -= weapon_crit_chance
	PlayerStats.ranged_damage -= weapon_range_damage

func attack() -> void:
	push_error("Should implement")

func _on_weapon_timer_timeout() -> void:
	can_attack = true
	
func get_direction() -> Vector2:
	return Vector2.RIGHT.rotated(rotation)
