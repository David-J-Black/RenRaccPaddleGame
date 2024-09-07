extends Node

var MainMenu := preload("res://scenes/menus/MainMenu.tscn")
var main_menu: Control


func _ready() -> void:
	main_menu = MainMenu.instantiate()
	main_menu.name = "MainMenu"
	var parent = get_node("/root/Main/MenuCanvas")

	# Move to front
	parent.add_child(main_menu)
	parent.move_child(main_menu, parent.get_child_count() - 1)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_menu"):
		toggle_main_menu()

func toggle_main_menu():
	set_visible(!main_menu.visible)

func set_visible(visibility: bool) -> void:
	main_menu.visible = visibility
	Dialogic.paused = visibility
	print("Is dialogic paused? [%s]" % Dialogic.paused)
	
