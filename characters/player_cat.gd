extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)
@export var axe_scene: PackedScene
@export var mop_scene: PackedScene
@export var shovel_scene: PackedScene
@export var chovel_scene: PackedScene
@export var body_scene: PackedScene
var facingDirection: Vector2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta: float) -> void:
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	if(input_direction != Vector2.ZERO):
		facingDirection = input_direction
	update_animation_parameters(input_direction)
	
	#update velocity
	velocity = input_direction * move_speed
	
	#move and slide function
	move_and_slide()
	pick_new_state()


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		


func _on_inventory_throw_axe() -> void:
	var axe = axe_scene.instantiate()
	axe.name = "axe" + str(RandomNumberGenerator.new().randi_range(1000,99999999999))
	get_parent().add_child(axe)
	axe.position = position + facingDirection
	axe.direction = facingDirection
	axe.ThrowInDirection()
	audio_stream_player_2d.play()


func _on_ui_throw_shovel() -> void:
	var shovel = shovel_scene.instantiate()
	shovel.name = "shovel" + str(RandomNumberGenerator.new().randi_range(10,99999999999))
	get_parent().add_child(shovel)
	shovel.position = position + facingDirection
	shovel.direction = facingDirection
	shovel.ThrowInDirection()
	audio_stream_player_2d.play()


func _on_ui_throw_chovel() -> void:
	var chovel = chovel_scene.instantiate()
	chovel.name = "chovel" + str(RandomNumberGenerator.new().randi_range(10,99999999999))
	get_parent().add_child(chovel)
	chovel.position = position + facingDirection
	chovel.direction = facingDirection
	chovel.ThrowInDirection()
	audio_stream_player_2d.play()


func _on_ui_throw_mop() -> void:
	var mop = mop_scene.instantiate()
	mop.name = "mop" + str(RandomNumberGenerator.new().randi_range(10,99999999999))
	get_parent().add_child(mop)
	mop.position = position + facingDirection
	mop.direction = facingDirection
	mop.ThrowInDirection()
	audio_stream_player_2d.play()


func _on_ui_throw_body() -> void:
	var body = body_scene.instantiate()
	body.name = "body" + str(RandomNumberGenerator.new().randi_range(10,99999999999))
	get_parent().add_child(body)
	body.position = position + facingDirection
	body.direction = facingDirection
	body.ThrowInDirection()
	audio_stream_player_2d.play()
