extends Node

signal player_collided(collision_position : Vector2, direction : Vector2)
signal shot_bullet(shot_position : Vector2, direction : Vector2, knockback: int)
signal shot_grenade(shot_position : Vector2, direction : Vector2)
signal shot_zombie_bullet(shot_position : Vector2, direction : Vector2, damage: int)
