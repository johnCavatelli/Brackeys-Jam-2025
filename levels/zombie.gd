extends CharacterBody2D

var movement_speed = 10
@export var target: Node2D = null

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	call_deferred("setup")

func setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position
		

func _physics_process(delta: float) -> void:
	if target:
		navigation_agent_2d.target_position = target.global_position
	if navigation_agent_2d.is_navigation_finished():
		return
	var pos = global_position
	var nextPathPos = navigation_agent_2d.get_next_path_position()
	velocity = pos.direction_to(nextPathPos) * movement_speed
	if(velocity.x > 0):
		animated_sprite_2d.play("walk_righ")
	elif(velocity.x < 0):
		animated_sprite_2d.play("walk_left")
	elif(velocity.y > 0):
		animated_sprite_2d.play("walk_Up")
	elif(velocity.y < 0):
		animated_sprite_2d.play("walk_down")
	move_and_slide()



func death():
	pass

func _on_hitbox_body_entered(body: Node2D) -> void:
	if(body.name.contains("axe") or body.name.contains("hovel") or body.name.contains("mop")):
		if(body.has_method("hit_objective")):
			body.hit_objective()
		death()
		
	
