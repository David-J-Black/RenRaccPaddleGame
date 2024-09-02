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
	add_child(map_viewer)
	print("MapView added to scene: Name:", map_viewer.name)

func render_map(name: String):
	var map_location = "res://scenes/maps" + name + ".tscn"
	
	#var map: Node2d = load(map_location)
	
func load_map(map_name: String):
	assert(map_name != null, "Invalid map name! [%s]" % map_name)
	if map_viewer != null:
		map_viewer.load_map(map_name)
	else:
		_new_map_viewer()
		map_viewer.load_map(map_name)

# A private function to make a new map viewer
func _new_map_viewer():
	if map_viewer != null:
		print("Warn: There is already a map viewer! Cannot make a new one")
		return
	
	map_viewer = MapViewer.instantiate()
	map_viewer.name = "MapView"
	add_child(map_viewer)
	print("MapView added to scene: Name:", map_viewer.name)
