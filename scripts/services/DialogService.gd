extends Node

func start_dialog(dialog_name: String):	
	if Dialogic.current_timeline != null:
		print("Dialogic already running a timeline! Cannot start dialog")
		return
		
	# If you go to the Dialogic tab, you can see this demo scene
	Dialogic.start(dialog_name)
	
