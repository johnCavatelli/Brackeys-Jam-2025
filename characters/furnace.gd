extends Node2D

@onready var animationPlayer = $AnimationPlayer
@export var stokeTime: float = 20
@export var burnout_scene : PackedScene
var coalLevel: int
var timeUntilDecreaseLevel: float


func _ready() -> void:
	animationPlayer.play("no_coal")
	coalLevel = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name.contains("shovel")):
		if(body.has_method("get_full_of_coal")):
			if(body.get_full_of_coal()):
				print("collided with shovel with coal in it")
				fill_furnace()
				body.blow_your_load()
	if(body.name.contains("chovel")):
		fill_furnace()
		body.blow_your_load()
		
func _process(delta: float) -> void:
	timeUntilDecreaseLevel -= delta
	if(timeUntilDecreaseLevel <= 0):
		decrease_level()


func decrease_level():
	coalLevel -= 1
	timeUntilDecreaseLevel = stokeTime
	updateAnim()
	if coalLevel == -1:
		Main.gameController.change_scene(burnout_scene.resource_path)

func fill_furnace():
	if coalLevel < 4:
		coalLevel += 1
	timeUntilDecreaseLevel = stokeTime
	updateAnim()

func updateAnim():
	match coalLevel:
		0:
			animationPlayer.play("no_coal")
		1:
			animationPlayer.play("coal_1")
		2:
			animationPlayer.play("coal_2")
		3:
			animationPlayer.play("coal_3")
	
