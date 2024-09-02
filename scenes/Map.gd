extends Node2D
class_name Map

#signal location_selected(name: string)

@onready var map_sprite: Sprite2D = $MapSprite
@onready var locations: Node = $Locations
@onready var MapLocation := preload("res://scenes/MapLocation.tscn")
@onready var init_map_scale

func _ready():
	print("MapView is ready")
	init_map_scale = map_sprite.scale
	set_location_initials()
	rescale()
	
	# Rescale everytime the viewport changes size
	get_viewport().connect("size_changed", Callable(self, "rescale"))
	print("Default Size of map ")
	
func set_location_initials():
	for node in locations.get_children():
		print("%s postition" % node.name, node.position)
	
# Change the size of this node based on the viewport
func rescale():
	assert(map_sprite is Sprite2D && map_sprite.texture is CompressedTexture2D ,"MapSprite is null or has no texture! Cannot rescale")
	
	var viewport_size: Vector2i = get_viewport().get_size()
	var texture: Texture2D = map_sprite.texture
	assert(texture is Texture2D, "INVALID TEXTURE")
	
	var texture_size: Vector2 = init_map_scale * texture.get_size()
	# If you don't wrap these in floats your return value is FUCKED
	var new_scale_value: float = float(viewport_size[0]) / float(texture_size[0])
	
	# Let's see if the new scale makes the image too tall...
	var too_tall: bool = texture_size[1] * new_scale_value > viewport_size[1]
	
	# If so, then we will shrink the scale so the image fits within the viewport
	if too_tall:
		new_scale_value = float(viewport_size[1]) / float(texture_size[1])
	
	# Apply the new scale
	self.scale = Vector2(new_scale_value, new_scale_value)

	
func location_node_selected(next_scene_info: GameSceneInformation):
	print("Processing next scene", next_scene_info.scene_name)
	
	if next_scene_info.close_map:
		queue_free()
	DialogService.start_dialog(next_scene_info.scene_name)
	
func get_locations() -> Array[MapLocation]:
	var children = locations.get_children()
	var response: Array[MapLocation] = []
	
	# get them damn location kids
	for child in children:
		if child is MapLocation:
			response.append(child)
	return response

func _location_hover(location: MapLocation):
	assert(location is MapLocation, "Invalid entity calling MapView.location_hover()")
	var mouse_position = get_viewport().get_mouse_position()

func _on_area_2d_mouse_entered() -> void:
	print("MOUSE TOUCHED ICON!!")
