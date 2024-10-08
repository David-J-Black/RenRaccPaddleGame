extends Node2D
class_name MapViewer

signal location_selected(name: String)

@onready var Map := preload("res://scenes/Map.gd")
var map: Map

func _ready():
	
	get_viewport().connect("size_changed", Callable(self, "resize"))
	resize()
	
func location_node_selected(scene_information: GameSceneInformation):
	print("Going to launch scene: ", scene_information.next_scene_name)
	
	# Right now we just start dialog, I think we'll need a service to process
	# The current situation before jumping straight into a scene
	match scene_information.scene_type:
		Enum.SceneType.DIALOG:
			DialogService.start_dialog(scene_information.scene_name)

func resize():
	var viewport_size: Vector2i = get_viewport().size
	
# Loads a map from the scenes/maps folder
func load_map(map_name: String):
	assert(map_name != null, "No map name given, c'mon man jesus christ")
	var file_path: String = "res://scenes/maps/" + map_name + ".tscn"
	var new_map: Resource = load(file_path) 
	assert(new_map != null, "Map [%s] not found" % map_name)

	# If we already have a map loaded, get that bitch outta here!
	if map != null:
		map.queue_free()

	var instiated_map = new_map.instantiate() as Map
	assert(instiated_map != null and instiated_map is Map, "Invalid Map Scene [%s]" % map_name)
	map = instiated_map
	map.name = map_name
	add_child(map)
