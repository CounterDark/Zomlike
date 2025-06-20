extends Control

@onready var exit_layer : CanvasLayer = $ExitLayer
@onready var container : Container =  $ExitLayer/Container

func _on_yes_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu/MainMenu.tscn")

func _on_no_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_visibility_changed() -> void:
	if self.visible:
		exit_layer.show()
		container.show()
	else:
		exit_layer.hide()
		container.hide()
