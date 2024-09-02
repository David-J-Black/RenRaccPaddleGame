extends Node2D

@export var starting_scene_name: String = "bellingham2"

@onready var control = $Control

func _ready() -> void:
	print("Hi! This is the start of the program")	
	assert(control != null && control is Control, "Control invalid!")
	
	# Everytime the window size changes, we will change this element
	adjust_size()
	get_viewport().connect("size_changed", Callable(self, "adjust_size"))
	
	MapService.load_map(starting_scene_name)

func load_map():
	MapService.render_map("bellingham")
	
func start_dialog():
	
	if Dialogic.current_timeline != null:
		print("Dialogic already running a timeline! Cannot start dialog")
		return
		
	# If you go to the Dialogic tab, you can see this demo scene
	Dialogic.start("demo_timeline")
	
func adjust_size():
	
	# Get and ensure the background is indeed, a background
	var background: TextureRect = control.get_node("Background")
	assert(background is TextureRect && background.texture is Texture, "Background is invalid!")
	background.size = get_viewport().get_size()
	background.z_index = -1
