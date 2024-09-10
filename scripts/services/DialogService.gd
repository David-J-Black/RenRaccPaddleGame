extends Node

var current_dialog: CanvasLayer
var next_timeline: String
	
# Start a dialog and specify what scene should play after dialog
func start_dialog(dialog_name: String) -> void:
	Dialogic.paused = false
	MenuService.set_visible(false)
	
	if current_dialog != null:
		#Dialogic.end_timeline()
		Dialogic.clear()
		Dialogic.start_timeline(dialog_name)
	else:
		set_current_dialog(Dialogic.start(dialog_name))

	# Make sure our scene name is up to date
	if dialog_name == null:
		dialog_name = GameService.get_scene_name()
				
func set_current_dialog(timeline: Variant):
	timeline.name = "dialog"
	timeline.layer = 1
	get_node("/root/Main/Background").add_sibling(timeline)
	current_dialog = timeline
	
func stop_dialog() -> void:
	print("Stopping dialog (JK THIS IS JUST A PRINT)")
	Dialogic.end_timeline()

func _dialog_end() -> void:
	print("Dialog ended")
	
