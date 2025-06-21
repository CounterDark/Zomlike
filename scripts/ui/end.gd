extends Control

@onready var end_layer : CanvasLayer = $EndLayer
@onready var container : Container =  $EndLayer/Container


func _on_visibility_changed() -> void:
	if self.visible:
		end_layer.show()
		container.show()
	else:
		end_layer.hide()
		container.hide()

func _on_return_pressed() -> void:
	get_tree().paused = false
	PlayerInventory.reset()
	PlayerStats.reset()
	Globals.reset()
	get_tree().change_scene_to_file("res://Scenes/main_menu/MainMenu.tscn")
