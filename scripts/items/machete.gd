extends Weapon

@onready var swing_sound : AudioStreamPlayer2D = $AttackSound

func attack() -> void :
	if can_attack:
		var direction = get_direction()
		var first_angle : float = direction.angle() - PI/4
		var next_angle : float = direction.angle() + PI/4
		can_attack = false
		attack_timer.start()
		var tween = create_tween().bind_node(self)
		tween.tween_property(self, "rotation", next_angle, attack_speed).from(first_angle).set_ease(Tween.EASE_OUT_IN)
		tween.play()
		swing_sound.play()

func _on_sword_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		var attack_damage : int = round(PlayerStats.damage * (1.0 if randf() > PlayerStats.crit_chance else PlayerStats.crit_multiplier))
		if "hit" in body:
			body.hit(attack_damage, get_direction(), knockback)
