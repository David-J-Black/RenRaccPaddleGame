extends Node

var current_dialog: CanvasLayer
# Start a dialog and specify what scene should play after dialog
func start_dialog(
	dialog_name: String
):
	if Dialogic.current_timeline != null:
		print("Dialogic already running a timeline! Cannot start dialog")
		return
		
	# Set up dialog scene and add it to right in front of backgraound
	var dialog: CanvasLayer = Dialogic.start(dialog_name)
	dialog.name = "dialog"
	dialog.layer = 1
	get_node("/root/Main/Background").add_sibling(dialog)
	
	MenuService.set_visible(false)
	
func stop_dialog() -> void:
	Dialogic.end_timeline()
