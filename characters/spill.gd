extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name.contains("mop")):
		if(body.has_method("hit_objective")):
			body.hit_objective()
			var levelManager = get_tree().get_nodes_in_group("Level")[0]
			levelManager.objectiveComplete()
			queue_free()
