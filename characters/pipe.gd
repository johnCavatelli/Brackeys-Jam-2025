extends Node2D

@export var state_1 : Sprite2D
@export var state_2 : Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name.contains("axe")):
		print("collided with AXE")
		change_state()
		
func change_state():
	state_1.hide()
	state_2.show()
	
