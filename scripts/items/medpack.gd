extends Item

@export var amount: int = 15

func use():
	PlayerStats.health+=amount
