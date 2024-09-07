extends Node

var MainMenu := preload("res://scenes/menus/MainMenu.tscn")
var main_menu: Control


func _ready() -> void:
	main_menu = MainMenu.instantiate()
	main_menu.name = "MainMenu"
	var parent = get_tree().root.get_node("Main")

	# Move to front
	parent.add_child(main_menu)
	parent.move_child(main_menu, parent.get_child_count() - 1)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_menu"):
		toggle_main_menu()

func toggle_main_menu():
	print("Toggling main menu", main_menu.visible)
	main_menu.visible = !main_menu.visible

func open_main_menu() -> void:
	main_menu.visible = true
	
func close_main_Menu() -> void:
	main_menu.vislble = false
