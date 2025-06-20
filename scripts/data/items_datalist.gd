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

func get_texture(item_id):
	return textures.get(item_id, null)
