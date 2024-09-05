extends Node2D

@export var starting_scene_name: String = "bellingham2"

@onready var control = $Control



func _ready() -> void:
	print("Hi! This is the start of the program")	
	assert(control != null && control is Control, "Control invalid!")
	
	# Everytime the window size changes, we will change this element
	adjust_size()
	get_viewport().connect("size_changed", Callable(self, "adjust_size"))
	
	SaveService.open_save_menu()

func adjust_size():
	
	# Get and ensure the background is indeed, a background
	var background: TextureRect = control.get_node("Background")
	assert(background is TextureRect && background.texture is Texture, "Background is invalid!")
	background.size = get_viewport().get_size()
	background.z_index = -1
