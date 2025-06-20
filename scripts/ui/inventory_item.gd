extends Control
class_name InventoryItem

@export var texture_rect: TextureRect

func set_item_by_id(id: String):
	var texture = ItemsDatalist.get_texture(id)
	if texture:
		texture_rect.texture = texture
