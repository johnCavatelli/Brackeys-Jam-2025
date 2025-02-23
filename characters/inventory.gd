extends Node2D

enum inventorySlot {
	empty, axe, mop, wrench, shovel, chovel, body
}

var currentSlot : inventorySlot = inventorySlot.empty
@export var texture : TextureRect
@export var axe_texture: Texture
@export var mop_texture: Texture
@export var shovel_texture: Texture
@export var chovel_texture: Texture
@export var body_texture: Texture
@export var empty_texture: Texture
@onready var pickup_sound: AudioStreamPlayer2D = $pickup_sound


signal throw_axe
signal throw_mop
signal throw_shovel
signal throw_chovel
signal throw_body

func axe_picked_up() -> void:
	currentSlot = inventorySlot.axe
	texture.texture = axe_texture
	pickup_sound.play()

func mop_picked_up() -> void:
	currentSlot = inventorySlot.mop
	texture.texture = mop_texture
	pickup_sound.play()

func shovel_picked_up() -> void:
	currentSlot = inventorySlot.shovel
	texture.texture = shovel_texture
	pickup_sound.play()
	
func chovel_picked_up() -> void:
	currentSlot = inventorySlot.chovel
	texture.texture = chovel_texture
	pickup_sound.play()
	
func body_picked_up() -> void:
	currentSlot = inventorySlot.body
	texture.texture = body_texture
	pickup_sound.play()

func throw_item() -> void:
	match currentSlot:
		inventorySlot.axe:
			throw_axe.emit()
		inventorySlot.mop:
			throw_mop.emit()
		inventorySlot.shovel:
			throw_shovel.emit()
		inventorySlot.chovel:
			throw_chovel.emit()
		inventorySlot.body:
			throw_body.emit()
	currentSlot = inventorySlot.empty
	texture.texture = empty_texture
	

func _process(delta):
	if(Input.get_action_strength("throw") and currentSlot != inventorySlot.empty):
		throw_item()
