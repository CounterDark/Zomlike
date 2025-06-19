extends Weapon

@onready var swing_sound : AudioStreamPlayer2D = $AttackSound

func attack() -> void :
	if can_attack:
		var direction = get_direction()
		var current_position : Vector2 = position
		var new_position : Vector2 = direction * 12
		var animation_time = attack_speed/2
		can_attack = false
		attack_timer.start()
		var tween = create_tween().bind_node(self)
		tween.tween_property(self, "position", new_position, animation_time).from_current().set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(self, "position", current_position, animation_time).from(new_position).set_ease(Tween.EASE_OUT_IN)
		tween.play()
		swing_sound.play()

func _on_sword_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		var attack_damage : int = round(PlayerStats.damage * (1.0 if randf() > PlayerStats.crit_chance else PlayerStats.crit_multiplier))
		if "hit" in body:
			body.hit(attack_damage, get_direction(), knockback)
