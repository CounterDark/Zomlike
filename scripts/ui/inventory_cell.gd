extends Control

var InventoryItemNode = preload('res://scenes/ui/inventory/InventoryItem.tscn')
var stored: Node = null

func set_item_by_id(id: String):
	if stored:
		stored.queue_free()
	var item: InventoryItem = InventoryItemNode.instantiate()
	item.set_item_by_id(id)
	stored = item
	add_child(item)
