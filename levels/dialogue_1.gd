extends Node2D

@export var scene : PackedScene
@export var dialogue_name_string : String = "01_opening_dialogue"

func _ready():
	Dialogic.signal_event.connect(dialogic_signal)
	Dialogic.start(dialogue_name_string)

func dialogic_signal(argument:String):
	print("GOT SIGNAL")
	if argument == "done_with_dialogue":
		print("done with dialogue")
		Main.gameController.change_scene(scene.resource_path)
