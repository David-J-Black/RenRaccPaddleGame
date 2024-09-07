extends Node
class_name Enum

# Describes a type of scene
# Not scene in the Godot sense, but more of "Are we loading a map, are we loading dialog?
enum SceneType {
	MAP,
	DIALOG
}

static func scene_type_from_string(scene_type_string: String) -> SceneType:
	assert(scene_type_string is String, "INVALID SCENE_TYPE")
	match scene_type_string:
		"DIALOG":
			return SceneType.DIALOG
		"MAP":
			return SceneType.MAP
		_:
			print("INVALID SCENE TYPE [%s]" % scene_type_string)
			return SceneType.MAP
