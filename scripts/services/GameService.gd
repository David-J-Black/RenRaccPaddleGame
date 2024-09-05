extends Node

var _scene_info: GameSceneInformation

# This should only be called by the save service
func apply_save(save_state: GameSceneInformation):
	_scene_info = save_state
	
	# Load scene
	match(save_state.scene_type):
		Enum.SceneType.MAP:
			MapService.load_map(save_state.scene_name)
		Enum.SceneType.DIALOG:
			DialogService.start_dialog(save_state.scene_name)
	
func get_state() -> GameSceneInformation:
	return _scene_info

# load up the events that occur upon a map getting loaded
func get_map_events(map_name: String) -> Array[MapEvent]:
	return _scene_info.map_events[map_name]
