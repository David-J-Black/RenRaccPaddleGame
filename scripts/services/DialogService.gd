extends Node

# Start a dialog and specify what scene should play after dialog
func start_dialog(
	dialog_name: String
):
	if Dialogic.current_timeline != null:
		print("Dialogic already running a timeline! Cannot start dialog")
		return
		
	Dialogic.start(dialog_name)
	
