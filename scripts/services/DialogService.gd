extends Node

var current_dialog: CanvasLayer

func _ready():
	# When dialogic ends a timeline, we should redirect to the last known scene if we have one
	Dialogic.timeline_ended.connect(Callable(self, "dialog_end"))
	
# Start a dialog and specify what scene should play after dialog
func start_dialog(dialog_name: String) -> void:
	if Dialogic.current_timeline != null:
		print("Dialogic already running a timeline! Cannot start dialog")
		return
		
	if (dialog_name != null):
		GameService.set_scene(dialog_name, Enum.SceneType.DIALOG)
	else:
		dialog_name = GameService.get_scene_name()	
	
	# Set up dialog scene and add it to right in front of backgraound
	var dialog: CanvasLayer = Dialogic.start(dialog_name)
	dialog.name = "dialog"
	dialog.layer = 1
	get_node("/root/Main/Background").add_sibling(dialog)
	
	MenuService.set_visible(false)
	Dialogic.paused = false
	
func stop_dialog() -> void:
	var dialog: Node = get_node("/root/Main/dialog")
	if dialog:
		dialog.queue_free()

func _dialog_end() -> void:
	print("Dialog ended")
	
