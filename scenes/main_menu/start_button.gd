extends Button

var level : PackedScene = preload("res://Scenes/levels/LevelOne.tscn")


func _on_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/levels/LevelOne.tscn")
	get_tree().change_scene_to_packed(level)
