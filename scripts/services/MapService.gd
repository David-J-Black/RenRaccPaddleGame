extends Node

# The MapView needs to be laoded
var MapViewerScene := preload("res://scenes/MapViewer.tscn")
var MapLocationScene := preload("res://scenes/MapLocation.tscn")

# This entity will act as our list of locations. We will stuff locations
# in them and they will exist as part of the scene
var locations: Node = Node.new()
var map_viewer: MapViewer

func _ready():
	map_viewer = MapViewerScene.instantiate()
	map_viewer.name = "MapView"
	get_node("/root/Main/Background").add_sibling(map_viewer)
	print("MapView added to scene: Name:", map_viewer.name)
	
func load_map(new_map_name: String):
	if (new_map_name != null):
		GameService.set_scene(new_map_name, Enum.SceneType.MAP)
	else:
		new_map_name = GameService.get_scene_name()
		
	assert(GameService.get_scene_name() != null, "No map, cannot load map!")
	
	map_viewer.load_map(GameService.get_scene_name())
