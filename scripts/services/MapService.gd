extends Node

# The MapView needs to be laoded
var MapViewer := preload("res://scenes/MapViewer.tscn")
var MapLocation := preload("res://scenes/MapLocation.tscn")

# This entity will act as our list of locations. We will stuff locations
# in them and they will exist as part of the scene
var locations: Node = Node.new()
var map_viewer: MapViewer
#func _ready():

func _ready():
	map_viewer = MapViewer.instantiate()
	map_viewer.name = "MapView"
	get_node("/root/Main/Background").add_sibling(map_viewer)
	print("MapView added to scene: Name:", map_viewer.name)
	
func load_map(map_name: String):
	assert(map_name != null, "Invalid map name! [%s]" % map_name)
	assert(map_viewer != null, "WHERE THE FUCK IS THE MAP VIEWER? JESUS FUCKING CHRIST DUDE!")	
	map_viewer.load_map(map_name)
