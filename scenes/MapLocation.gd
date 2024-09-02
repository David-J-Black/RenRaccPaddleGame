extends Node2D
class_name MapLocation

@export var display_name: String = "Set me"
@export var dialog_start_name: String

@onready var label: Label = $Label
@onready var area: Area2D = $Area2D
@onready var MapView := preload("res://scenes/MapView.gd")
@onready var initial_position: Vector2 = position
@onready var initial_scale: Vector2 = scale


signal location_selected(name: String)

var map_view: MapView
var mouse_clicked: bool = false

func _ready():
	get_map_view()
	map_view.connect("on_resize", Callable(self, "_on_resize"))
	label.visible = false
	label.text = display_name
	
# Locations should have reference to the MapView object
func get_map_view():
	var parent: Node = get_parent()
	
	assert(parent != null, "No parent to this location!")	
	assert(parent is Node, "Location has an invalid parent")
		
	map_view = parent.get_parent()
	assert(map_view is MapView, "Missing expected MapView parent! Make sure this Location is a child to the Locations node!")
		
func resize(map_scale: float):
		position = initial_position * map_scale
		scale = initial_scale * map_scale
		print ("New node position for %s!" % name, position)

# Detecting clicks...
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_action("mouse_click"):
		emit_signal("location_selected", name)
		
		assert(dialog_start_name != null, "YOU NEED A DIALOG TO ATTACH TO THIS LOCATION!")
		map_view.location_node_selected(dialog_start_name)

func _on_area_2d_mouse_exited() -> void:
	print("goodbye label; pos: ", label.position)
	if label && label.visible:
		label.visible = false


func _on_area_2d_mouse_entered() -> void:
	print("Showing label; pos: ", label.position)
	if label:
		label.visible = true
