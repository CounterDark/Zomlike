extends Node
class_name ItemDatalist

var textures := {
	"sword": preload('res://resources/items/sword.tres'),
	"machine": preload('res://resources/items/machine.tres'),
	"machete": preload('res://resources/items/machete.tres'),
	"rifle": preload('res://resources/items/rifle_texture.tres'),
	"launcher": preload('res://resources/items/grenade_launcher.tres'),
	"medpack": preload('res://resources/items/medpack.tres')
}

var ids_list:
	get():
		return textures.keys()

func get_node_for_id(id: String):
	if id == "sword":
		return preload('res://scenes/items/sword.tscn')
	elif  id == "machine":
		return preload('res://scenes/items/machine.tscn')
	elif id == "machete":
		return preload('res://scenes/items/machete.tscn')
	elif id == "rifle":
		return preload('res://scenes/items/assault_rifle.tscn')
	elif id == "launcher":
		return preload('res://scenes/items/granade_launcher.tscn')
	else:
		return null

func get_texture(item_id):
	return textures.get(item_id, null)
