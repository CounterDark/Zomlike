extends GridContainer

var cellNode = preload('res://scenes/ui/inventory/InventoryCell.tscn')

func _draw() -> void:
	for id in PlayerInventory.items_ids:
		var cell: InventoryCell = cellNode.instantiate()
		cell.set_item_by_id(id)
