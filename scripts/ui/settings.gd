extends Control

@onready var volume_slider : HSlider = $UI/Controls/VBoxContainer/VolumeSlider
@onready var master_bus_index : int = AudioServer.get_bus_index("Master")

func _ready():
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
