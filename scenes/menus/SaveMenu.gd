extends Control

@onready var save_list: VBoxContainer = $SaveMenu/PanelContainer/MarginContainer/SaveList
@onready var load_button: Button = $SaveMenu/Buttons/Load
	
var selected: String

func _ready() -> void:
	self.visible = true

	# Populate the save list
	var saves: Array[String] = SaveService.get_save_names()

	for save in saves:
		add_file_entry(save)

		
func _on_load_pressed() -> void:
	assert(selected != null, "SAVE NAME NULL? DUDE LOOK INTO THIS")
	SaveService.load_save_file(selected)
	
func _on_file_pressed(save_name: String) -> void:
	print("selected [%s]" % save_name)
	selected = save_name

# This shit is so cheese
func bring_menu_to_front(menu: Control) -> void:
	remove_child(menu)
	add_child(menu)
	
func add_file_entry(save_name: String) -> void:
	var button = Button.new()
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.text = save_name
	button.name = save_name
	button.connect("pressed", Callable(self, "_on_file_pressed").bind(save_name))
	save_list.add_child(button)
	print("list children", save_list.get_children())
