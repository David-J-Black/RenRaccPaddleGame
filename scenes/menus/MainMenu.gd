extends Control

var MENU_SCALE: float = 0.9

@onready var save_menu: Control = $MainMenuPanel/MarginContainer/HBoxContainer/Window/SaveMenu
@onready var panel: Panel = $MainMenuPanel

func _ready() -> void:
	assert(save_menu != null, "SAVE MENU IS NULL?!")
	save_menu.visible = true
	#load_menu.visible = false
	_resize()
	get_viewport().connect("size_changed", Callable(self, "_resize"))

func _resize() -> void:
	var viewport_size = get_viewport().get_size()
	print("Viewport size ", viewport_size)
	panel.size = viewport_size
	#position = (viewport_size - Vector2i(size)) / 2
	print("Main menu's size",size, "pos",position, " position on tree", get_tree().root.get_children())
