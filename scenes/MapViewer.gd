extends Node2D
class_name MapViewer

#signal location_selected(name: string)

@onready var map_sprite: Sprite2D = $MapSprite
@onready var map_view: Node2D = $BoxContainer/MarginContainer/ViewportContainer/SubViewport/MapView

func _ready():
	print("MapView is ready")
	# self.z_index = 10
	
	# Rescale everytime the viewport changes size
	get_viewport().connect("size_changed", Callable(self, "resize"))
	resize()
	print("Default Size of map ")
		
func location_node_selected(node_name: String):
	print("You selected: ", node_name)
	DialogService.start_dialog(node_name)

func resize():
	var viewport_size: Vector2i = get_viewport().size
