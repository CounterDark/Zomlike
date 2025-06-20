extends Node

const MAX_SLOTS := 6

var items_ids: Array[String] = []

var equiped_index: int = -1

func can_add() -> bool:
	return len(items_ids) < MAX_SLOTS

func add_item(id: String):
	if can_add():
		items_ids.append(id)

func remove_item(index: int):
	if index < len(items_ids):
		items_ids.remove_at(index)
		if equiped_index == index:
			equiped_index = -1

func equip_item(index: int):
	if index < len(items_ids):
		equiped_index = index

func get_equiped_id():
	if equiped_index < 0:
		return null
	return items_ids[equiped_index]

func get_at_index(index: int):
	if index < len(items_ids):
		return items_ids[index]
	else:
		return null
