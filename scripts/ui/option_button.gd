extends OptionButton

func _ready() -> void:
	select(Difficulty.game_difficulty)

func item_selected(index: int) -> void:
	Difficulty.game_difficulty = index
