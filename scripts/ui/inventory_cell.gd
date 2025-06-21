extends Control
class_name InventoryCell
 
@export var item: InventoryItem
var stored
var index: int = -1

func set_item_by_id(id: String):
	item.item_index = index
	item.set_item_by_id(id)
	stored = id
	item.visible = true

func remove_item():
	stored = null
	item.visible = false

func set_index(value: int):
	index = value
