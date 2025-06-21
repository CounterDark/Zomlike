extends Node2D

var level = preload('res://scenes/levels/LevelTwo.tscn')

@export var label: Label

var is_near = false

func _process(delta: float) -> void:
	if is_near and Input.is_action_pressed("primary action"):
		next_level()

func next_level():
	get_tree().change_scene_to_packed(level)



func _on_opening_area_body_entered(body: Node2D) -> void:
	is_near = true
	if label:
		label.visible = true


func _on_opening_area_body_exited(body: Node2D) -> void:
	is_near = false
	if label:
		label.visible = false
