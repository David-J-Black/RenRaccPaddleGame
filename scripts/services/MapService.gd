extends Node

# The MapView needs to be laoded
var MapViewerScene := preload("res://scenes/MapViewer.tscn")
var LocationScene := preload("res://scenes/MapLocation.tscn")

# This entity will act as our list of locations. We will stuff locations
# in them and they will exist as part of the scene
var locations: Node = Node.new()
var map_viewer: MapViewer
#func _ready():

func _ready():
	map_viewer = MapViewerScene.instantiate()
	map_viewer.name = "MapView"
	add_child(map_viewer)
	print("MapView added to scene: Name:", map_viewer.name)


func render_map(name: String):
	var map_location = "res://scenes/maps" + name + ".tscn"
	
	#var map: Node2d = load(map_location)
	
func open_window():
	print("You tried to open the mapviewer")
	
