extends Control


@export var startScene : PackedScene

var level_instance : Node2D

func _ready():
	load_level(startScene)
	

func unload_level():
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null
	
func load_level(level : PackedScene):
	unload_level()
	level_instance = level.instantiate()
	get_tree().root.add_child.call_deferred(level_instance)

func _process(delta):
	if Input.is_action_just_pressed("reset"):
		load_level(startScene)
	if Input.is_action_just_pressed("exit"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
