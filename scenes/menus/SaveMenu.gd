extends Control

@onready var save_list: VBoxContainer = $SaveMenu/PanelContainer/MarginContainer/SaveList
	
func _on_load_pressed() -> void:
	self.visible = true
	
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
