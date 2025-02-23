extends CharacterBody2D

var is_player_inside: bool = false
var inventory : Node2D
@export var sprite: Sprite2D
@export var emptyTexture: Texture
@export var fullOfCoalTexture: Texture
@export var throw_speed: float = 500
@export var direction: Vector2 = Vector2.ZERO
var hasCoal : bool = true

func _ready():
	set_as_top_level(true)# Makes sure it doesn't get affected by the parent's transforms
	inventory = get_tree().get_nodes_in_group("UI")[0]


func _process(delta):
	if(Input.get_action_strength("interact") != 0 and (inventory.currentSlot == 0) and is_player_inside):
			if hasCoal:
				inventory.chovel_picked_up()
			else:
				inventory.shovel_picked_up()
			queue_free()
	if(velocity.length() > 0.2):
		velocity *= 0.95
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func ThrowInDirection() -> void:
	print(direction)
	velocity = direction * throw_speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player_inside = false
	
func hit_objective():
	velocity *= 0.1
	
func fill_shovel_with_coal():
	sprite.texture = fullOfCoalTexture
	hit_objective()
	hasCoal = true
	
	
func blow_your_load():
	sprite.texture = emptyTexture
	hit_objective()
	hasCoal = false
	
func get_full_of_coal():
	return hasCoal
