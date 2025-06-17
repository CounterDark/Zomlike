extends Button

func _pressed() -> void:
	var main_menu = ResourceLoader.load("res://scenes/main_menu/MainMenu.tscn")
	get_tree().change_scene_to_packed(main_menu)
