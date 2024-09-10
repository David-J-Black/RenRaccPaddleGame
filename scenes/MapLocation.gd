extends Node2D
class_name MapLocation

@export var display_name: String = "Set me"
@export var scene_name: String
@export var scene_type: Enum.SceneType = Enum.SceneType.DIALOG

@onready var label: Label = $Label
@onready var area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var initial_position: Vector2 = position
@onready var initial_scale: Vector2 = scale
@onready var initial_label_scale: Vector2 = label.scale
@onready var initial_label_pos: Vector2 = label.position


signal location_selected(name: String)

var map: Map
var mouse_clicked: bool = false

func _ready():
	_get_map()
	map.connect("on_resize", Callable(self, "_on_resize"))
	label.text = display_name
	
# Locations should have reference to the MapView object
func _get_map():
	var parent: Node = get_parent()
	
	assert(parent != null, "No parent to this location!")	
	assert(parent is Node, "Location has an invalid parent")
		
	map = parent.get_parent()
	assert(map is Map, "Missing expected MapView parent! Make sure this Location is a child to the Locations node!")
		
func _on_resize(map_scale: float):
		position = initial_position * map_scale
		scale = initial_scale * map_scale
		print ("New node position for %s!" % name, position)

# Detecting clicks...
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("mouse_click"):
		
		emit_signal("location_selected", name)
		assert(scene_name != null, "YOU NEED A DIALOG TO ATTACH TO THIS LOCATION!")
		var scene_information := GameSceneInformation.new()
		scene_information.scene_name = self.scene_name
		scene_information.scene_type = self.scene_type
		
		# TODO: CHANGE THE FOLLOWING, I want us to be more flexible with game flows, 
		map.location_node_selected(scene_information)

func _on_area_2d_mouse_exited() -> void:
	print("goodbye label; pos: ", label.position)
	if label:
		label.scale = initial_label_scale
		label.position = initial_label_pos


func _on_area_2d_mouse_entered() -> void:
	print("Showing label; pos: ", label.position)
	if label:
		# TODO: Fix this scaling thing so it pops up, and maybe more animated
		label.scale = initial_label_scale * 1.5
		var scale_difference = initial_label_scale - label.scale
		var scale_pos_diff = (scale_difference * label.size)/2
		label.position = initial_label_pos + scale_pos_diff
