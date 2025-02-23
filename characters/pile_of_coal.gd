extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name.contains("shovel")):
		if(body.has_method("fill_shovel_with_coal")):
			body.fill_shovel_with_coal()
