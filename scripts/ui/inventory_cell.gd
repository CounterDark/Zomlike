extends Control
class_name InventoryCell
 
@export var item: InventoryItem
var stored

func _ready() -> void:
	item.visible = false

func set_item_by_id(id: String):
#	item.set_item_by_id(id)
	stored = id
#	item.visible = true

func remove_item():
	stored = null
	item.visible = false
