extends Control
class_name InventoryItem

@export var texture_rect: TextureRect
@export var equip_glow: ColorRect
var item_id: String
var equiped:
	get():
		return item_id == PlayerInventory.get_equiped_id()

func set_item_by_id(id: String):
	var texture = ItemsDatalist.get_texture(id)
	if texture:
		texture_rect.texture = texture
		item_id = id
		equip_glow.visible = equiped
