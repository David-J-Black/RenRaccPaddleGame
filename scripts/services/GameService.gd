extends Node

var _scene_info: GameSceneInformation

# This should only be called by the save service
func apply_save(save_state: GameSceneInformation):
	_scene_info = save_state
	
	# Blow up any running dialog scenes
	DialogService.stop_dialog()
	MenuService.set_visible(false)
	
	# Load scene
	print("Scene type we are applying [%s]" % save_state.scene_type)
	match(save_state.scene_type):
		Enum.SceneType.MAP:
			MapService.load_map(save_state.scene_name)
		Enum.SceneType.DIALOG:
			print("Going to load dialog [%s]" % save_state.scene_name)
			DialogService.start_dialog(save_state.scene_name)
		_:
			assert("INVALID SCENE TYPE [%s]" % save_state.scene_type) 
	
# Grabe the entire "current state" of the game
# Including, what time it is, where the user currently is
func get_state() -> GameSceneInformation:
	return _scene_info

# load up the events that occur upon a map getting loaded
func get_map_events(map_name: String) -> Array[MapEvent]:
	return _scene_info.map_events[map_name]
