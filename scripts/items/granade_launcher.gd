extends Weapon

@onready var granade_marker : Marker2D = $GrenadeMarker 
@onready var shot_sound : AudioStreamPlayer2D = $GrenadeLaunchSound

func attack() -> void:
	if can_attack:
		var direction = get_direction()
		can_attack = false
		attack_timer.start()
		SignalBus.shot_grenade.emit(granade_marker.global_position, direction)
		shot_sound.play()
