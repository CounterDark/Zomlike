extends Node2D

@export var opened: bool = false
@export var closedSprite: Sprite2D
@export var openedSprite: Sprite2D

signal chest_opened

func open_chest():
	if not opened:
		closedSprite.visible = false
		openedSprite.visible = true
		opened = true
		chest_opened.emit()
