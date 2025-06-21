extends Node

const MAX_SLOTS := 6

var items_ids: Array[String] = []

var equiped_index: int = -1

signal weapon_changed

func can_add() -> bool:
	return len(items_ids) < MAX_SLOTS

func add_item(id: String) -> void:
	if can_add():
		items_ids.append(id)

func remove_item(index: int) -> void:
	if index < len(items_ids):
		items_ids.remove_at(index)
		if equiped_index == index:
			equiped_index = -1
			weapon_changed.emit()

func equip_item(index: int) -> void:
	if index < len(items_ids):
		equiped_index = index
		weapon_changed.emit()
		
func unequip_item() -> void:
	equiped_index = -1
	weapon_changed.emit()

func get_equiped_id() -> Variant:
	if equiped_index < 0:
		return null
	return items_ids[equiped_index]

func get_at_index(index: int) -> Variant:
	if index < len(items_ids):
		return items_ids[index]
	else:
		return null
		
func get_node_for_id(id: String) -> Variant:
	return ItemsDatalist.get_node_for_id(id)

func get_equiped_node() -> Variant:
	if equiped_index < 0:
		return null
	else:
		return ItemsDatalist.get_node_for_id(get_equiped_id())

func reset():
	items_ids.clear()
	equiped_index = -1
