extends Node2D

@export var state_1 : AnimatedSprite2D
@export var state_2 : Sprite2D
var hit : bool
@onready var fix_noise: AudioStreamPlayer2D = $fixNoise

func _ready() -> void:
	hit = false
	state_1.play("idle")
	state_1.show()
	state_2.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name.contains("axe")):
		if(body.has_method("hit_objective")):
			body.hit_objective()
		print("collided with AXE")
		if not hit:
			change_state()
		
func change_state():
	fix_noise.play()
	state_1.hide()
	state_2.show()
	hit = true
	var levelManager = get_tree().get_nodes_in_group("Level")[0]
	levelManager.objectiveComplete()
	
