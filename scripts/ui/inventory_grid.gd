extends GridContainer

var cellNode = preload('res://scenes/ui/inventory/InventoryCell.tscn')

func _draw() -> void:
	for child in get_children():
		child.free()
	for i in range(0, PlayerInventory.MAX_SLOTS):
		var cell: InventoryCell = cellNode.instantiate()
		var id = PlayerInventory.get_at_index(i)
		if id:
			cell.set_item_by_id(id)
		add_child(cell)
