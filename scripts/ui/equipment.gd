extends Control

@onready var kill_count : Label = $EquipmentLayer/Stats/KillCount
@onready var time : Label = $EquipmentLayer/Stats/Time
@onready var stats : GridContainer = $EquipmentLayer/Stats
@onready var grid_container : GridContainer = $EquipmentLayer/GridContainer
@onready var equipment_layer : CanvasLayer = $EquipmentLayer


func _ready() -> void:
	kill_count.text = str(PlayerStats.kill_count) + " zombies killed"
	time.text = str(PlayerStats.time_played) + " time played (s)"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		self.hide()
		get_tree().paused = false

func _on_visibility_changed() -> void:
	if self.visible:
		kill_count.text = str(PlayerStats.kill_count) + " zombies killed"
		time.text = str(snappedf(PlayerStats.time_played, 0.01)) + " time played (s)"
		stats.show()
		grid_container.show()
		equipment_layer.show()
		queue_redraw()
	else:
		stats.hide()
		grid_container.hide()
		equipment_layer.hide()
