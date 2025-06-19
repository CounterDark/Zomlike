extends Weapon

@onready var bullet_marker : Marker2D = $BulletMarker 
@onready var shot_sound : AudioStreamPlayer2D = $BulletSound

func attack() -> void:
	if can_attack:
		var direction = get_direction()
		can_attack = false
		attack_timer.start()
		SignalBus.shot_bullet.emit(bullet_marker.global_position, direction, knockback)
		shot_sound.play()
