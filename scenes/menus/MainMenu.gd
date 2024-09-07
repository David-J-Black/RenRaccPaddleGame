extends Control

var MENU_SCALE: float = 0.9

@onready var save_menu: Control = $HBoxContainer/Window/SaveMenu

func _ready() -> void:
	assert(save_menu != null, "SAVE MENU IS NULL?!")
	save_menu.visible = true
	#load_menu.visible = false
	_adjust_size()
	get_viewport().connect("size_changed", Callable(self, "_adjust_size"))

func _adjust_size() -> void:
	var viewport_size = get_viewport().get_size()
	print("Viewport size ", viewport_size)
	size = viewport_size * MENU_SCALE
	position = (viewport_size - Vector2i(size)) / 2
	print("Main menu's size",size, "pos",position, " position on tree", get_tree().root.get_children())
