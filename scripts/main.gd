extends Node2D

func _ready() -> void:
	print("Hi! This is the start of the program")	
	start_dialog()
	
func start_dialog():
	
	if Dialogic.current_timeline != null:
		print("Dialogic already running a timeline! Cannot start dialog")
		return
		
	# If you go to the Dialogic tab, you can see this demo scene
	Dialogic.start("demo_timeline")
