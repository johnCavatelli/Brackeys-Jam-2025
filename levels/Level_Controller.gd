extends Node2D

var timer_label = Label 
var objectives_label = Label 
var timer = Timer
var objectivesComplete: int
@export var totalObjectives: int
@export var LowTimeColor : Color
@export var OgColor : Color

func _ready():
	timer_label = $Camera2D/UI/CanvasLayer/Label
	objectives_label = $Camera2D/UI/CanvasLayer/Label2
	timer = $Camera2D/UI/CanvasLayer/Timer
	objectivesComplete = 0
	timer.start()


func _process(delta):
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
	if objectivesComplete >= totalObjectives:
		WinLevel()
	else:
		LooseLevel()
		
	
func WinLevel():
	pass
	
func LooseLevel():
	pass
	
func objectiveComplete():
	objectivesComplete += 1
	objectives_label.text = "Objectives Complete: " + str(objectivesComplete)
