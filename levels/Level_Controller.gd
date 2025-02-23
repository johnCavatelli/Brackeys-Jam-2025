extends Node2D

var timer_label = Label 
var objectives_label = Label 
var timer = Timer
var objectivesComplete: int
@export var totalObjectives: int
@export var LowTimeColor : Color
@export var OgColor : Color
@export var win_scene : PackedScene
@export var lose_scene : PackedScene
@export var timerLength : float

func _ready():
	timer_label = $Camera2D/UI/CanvasLayer/Label
	objectives_label = $Camera2D/UI/CanvasLayer/Label2
	timer = $Camera2D/UI/CanvasLayer/Timer
	objectivesComplete = totalObjectives
	objectives_label.text = "State of the Factory: " + sleepNoMore(objectivesComplete)
	timer.set_wait_time(timerLength)
	timer.start()


func _process(_delta):
	update_lable_text()
	if timer.time_left <= 0.1:
		timer_up()
	elif timer.time_left <= 10:
		timer_label.modulate = LowTimeColor
	else:
		timer_label.modulate = OgColor
	
func update_lable_text():
	timer_label.text = "Time Left: " + str(ceil(timer.time_left))
	

func timer_up():
	timer.stop()
	if objectivesComplete <= 0:
		WinLevel()
	else:
		LooseLevel()
		
	
func WinLevel():
	await get_tree().create_timer(1.5).timeout
	Main.gameController.change_scene(win_scene.resource_path)
	
func LooseLevel():
	Main.gameController.change_scene(lose_scene.resource_path)
	
func objectiveComplete():
	objectivesComplete -= 1
	objectives_label.text = "State of the Factory: " + sleepNoMore(objectivesComplete)
	if objectivesComplete == 0:
		await get_tree().create_timer(1.5).timeout
		WinLevel()

func sleepNoMore(foo : int):
	if foo == 0:
		return "PERFECT"
	elif foo <= 2:
		return "Almost Fixed"
	elif foo <= 4:
		return "Kinda Close"
	elif foo <= 7:
		return "Filthy"
	else:
		return "Overwhelming Disrepear"
