class_name GameController extends Node

@export var world_2d : Node2D
var current_2d_scene

func _ready() -> void:
	Main.gameController = self
	current_2d_scene = $World2D/TitleScreen

func change_scene(new_scene: String, delete: bool = true, keep_running: bool = false):
	if delete:
		current_2d_scene.queue_free()
	elif keep_running:
		current_2d_scene.visible = false
	else:
		world_2d.remove_child(current_2d_scene)
	var new = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
	
