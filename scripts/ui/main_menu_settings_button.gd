extends Button

var settings : PackedScene = preload("res://scenes/main_menu/settings/Settings.tscn")

func _pressed() -> void:
	get_tree().change_scene_to_packed(settings)
