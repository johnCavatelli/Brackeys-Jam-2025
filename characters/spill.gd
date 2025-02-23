extends Node2D
@onready var mop_up_noise: AudioStreamPlayer2D = $mopUpNoise

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name.contains("mop")):
		if(body.has_method("hit_objective")):
			mop_up_noise.play()
			body.hit_objective()
			var levelManager = get_tree().get_nodes_in_group("Level")[0]
			levelManager.objectiveComplete()
			await get_tree().create_timer(0.4).timeout
			queue_free()
