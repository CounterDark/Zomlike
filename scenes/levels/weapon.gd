extends RigidBody2D
class_name Weapon

var attack_speed : float
var can_attack: bool = true
#chyba powinniśmy tworzyć timer nie w parent scenie a już w dziedziczonych, ale nie będziemy pewnie mieli więcej niż jednej broni naraz użytej
@onready var attack_timer : Timer = $WeaponTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attack():
	if can_attack:
		print("attack")
		attack_timer.start(attack_speed)
		can_attack = false

func _on_weapon_timer_timeout() -> void:
	can_attack = true
