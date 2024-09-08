extends Node

var MainMenu := preload("res://scenes/menus/MainMenu.tscn")
var main_menu: Control

# For use when the user spawns a confirm dialog
var confirm_response: bool = false
var _confirm_menu: AcceptDialog

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
	
# Make a dialog pop up so a user can confirm an action
func make_confirm_menu(text: String) -> bool:
	_confirm_menu = AcceptDialog.new()
	_confirm_menu.dialog_text = text
	_confirm_menu.connect("confirmed", Callable(self, "_on_confirm"))
	_confirm_menu.connect("canceled", Callable(self, "_on_cancel"))
	main_menu.add_child(_confirm_menu)
	print("confirm menu position [%s]" % _confirm_menu.position, " Size [%s]" % _confirm_menu.size)
	
	await _confirm_menu_response
	return confirm_response
	
	
# Confirm menu logid:
# Confirm menu will call one of these two functions
func _on_confirm():
	confirm_response = true
	_confirm_menu_response()

func _on_cancel():
	confirm_response = false
	_confirm_menu_response()
	
func _confirm_menu_response():
	pass
