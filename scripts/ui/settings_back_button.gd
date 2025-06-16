extends Button

#var main_menu : PackedScene = preload("res://scenes/main_menu/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _pressed() -> void:
	var main_menu = ResourceLoader.load("res://scenes/main_menu/MainMenu.tscn")
	get_tree().change_scene_to_packed(main_menu)
