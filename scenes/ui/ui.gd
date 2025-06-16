extends CanvasLayer

@onready var health_bar: TextureProgressBar = $Container/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerStats.connect("stat_change", update_stats)
	update_stats()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_stats():
	update_health_bar()
	
func update_health_bar():
	health_bar.value = 100.0 * PlayerStats.health / PlayerStats.max_health
	
