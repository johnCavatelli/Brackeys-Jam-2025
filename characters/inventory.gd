extends Node2D

enum inventorySlot {
	empty, axe, mop, wrench
}

var currentSlot : inventorySlot = inventorySlot.empty
@export var texture : TextureRect
@export var axe_texture: Texture
@export var mop_texture: Texture
@export var empty_texture: Texture

signal throw_axe
signal throw_mop

func axe_picked_up() -> void:
	currentSlot = inventorySlot.axe
	texture.texture = axe_texture
	

func throw_item() -> void:
	match currentSlot:
		inventorySlot.axe:
			throw_axe.emit()
		inventorySlot.mop:
			throw_mop.emit()
	currentSlot = inventorySlot.empty
	texture.texture = empty_texture
	

func _process(delta):
	if(Input.get_action_strength("throw") and currentSlot != inventorySlot.empty):
		throw_item()
