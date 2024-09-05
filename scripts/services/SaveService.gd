extends Node

var _save_state: Dictionary = {}
var save_name

func get_save_state() -> Dictionary:
	return _save_state
	
func load_save_file(save_name: String):
	if save_name == null:
		save_name = "save"
	var file_address = "res://saves/" + save_name + ".json"
	if not FileAccess.file_exists(file_address):
		print("Invalid save file")
		
	var save_file = FileAccess.open(file_address, FileAccess.READ)
	_save_state = save_file
	save_name = save_name
	return _save_state
	
func commit_save_state(local_save_name: String) -> void:
	if local_save_name != null:
		save_name = local_save_name
	
	var file = FileAccess.open(local_save_name, FileAccess.WRITE)
