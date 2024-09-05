extends Control

@onready var save_list: VBoxContainer = $Load/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/SaveList
@onready var load_menu: Container = $Load
@onready var main_menu: Container = $Main

func _ready() -> void:
	main_menu.visible = true
	load_menu.visible = false


func _on_load_pressed() -> void:
	load_menu.visible = true
	main_menu.visible = false
	bring_menu_to_front(load_menu)
	
	# Populate the save list
	var saves: Array[String] = SaveService.get_save_names()
	
	for save in saves:
		var button = Button.new()
		button.text = save
		button.name = name
		button.connect("pressed", Callable(self, "_on_file_pressed").bind(save))
		save_list.add_child(button)
		print("list children", save_list.get_children())
	
func _on_file_pressed(save_name: String) -> void:
	print("selected [%s]" % save_name)
	SaveService.load_save_file(save_name)
	queue_free()

# This shit is so cheese
func bring_menu_to_front(menu: Control) -> void:
	remove_child(menu)
	add_child(menu)
