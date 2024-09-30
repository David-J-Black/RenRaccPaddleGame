extends Node2D

@export var starting_scene_name: String = "bellingham2"
@onready var background: TextureRect = $Background

func _ready() -> void:
	print("Hi! This is the start of the program")	
	assert(background != null && background is TextureRect, "Control invalid!")
	
	# Everytime the window size changes, we will change this element
	_adjust_size()
	get_viewport().connect("size_changed", Callable(self, "_adjust_size"))
	MenuService.set_visible(true)
	
func _adjust_size():
	
	# Get and ensure the background is indeed, a background
	assert(background is TextureRect && background.texture is Texture, "Background is invalid!")
	var viewport_size = get_viewport().get_size()
	background.size = viewport_size
	background.z_index = -1
	
"res://scenes/main.tscn"
