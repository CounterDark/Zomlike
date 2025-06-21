extends Control
class_name InventoryItem

@export var texture_rect: TextureRect
@export var equip_glow: ColorRect
var item_id: String
var item_index: int

func set_item_by_id(id: String):
	var texture: Texture2D = ItemsDatalist.get_texture(id)
	if texture:
		texture_rect.texture = texture
		item_id = id
		equip_glow.visible = is_equiped()
		
func is_equiped() -> bool:
	return item_index == PlayerInventory.equiped_index

func _on_click_area_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		if is_equiped():
			PlayerInventory.unequip_item()
		else:
			PlayerInventory.equip_item(item_index)
		equip_glow.visible = is_equiped()

func _ready() -> void:
	PlayerInventory.weapon_changed.connect(onWeaponChanged)
	
func onWeaponChanged():
	equip_glow.visible = is_equiped()
