extends Node2D

@export var opened: bool = false
@export var closedSprite: Sprite2D
@export var openedSprite: Sprite2D
@export var label: Label

signal chest_opened

var is_near = false

func _process(delta: float) -> void:
	if is_near and Input.is_action_pressed("primary action"):
		open_chest()

func open_chest():
	if not opened:
		closedSprite.visible = false
		openedSprite.visible = true
		opened = true
		chest_opened.emit()
		give_item()
		label.queue_free()

func give_item():
	var items_ids = ItemsDatalist.ids_list
	var id = items_ids[randi() % items_ids.size()]
	PlayerInventory.add_item(id)


func _on_opening_area_body_entered(body: Node2D) -> void:
	is_near = true
	if label:
		label.visible = true


func _on_opening_area_body_exited(body: Node2D) -> void:
	is_near = false
	if label:
		label.visible = false
