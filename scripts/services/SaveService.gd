extends Node

var FILE_LOCATION = "res://saves/"
var save_name: String = "save_file"

func load_save_file(save_name: String):
	if save_name == null:
		save_name = "save"

	var file_address = FILE_LOCATION + save_name + ".json"
	if not FileAccess.file_exists(file_address):
		print("Invalid save file")
		return
		
	var save_file = FileAccess.open(file_address, FileAccess.READ)
	var save_text: String = save_file.get_as_text()
	save_file.close()

	var parse_result = JSON.parse_string(save_text)

	if parse_result == null:
		print("INVALID SAVE")
		return

	# Populate a game scene information object
	var response := GameSceneInformation.new()
	response = dict_to_class(parse_result, response)

	GameService.apply_save(response)
	print("Finished loading save")
	
func commit_save_state(local_save_name: String) -> void:
	if local_save_name == null:
		local_save_name = save_name
	
	# Grab the game informationn
	var game_state: GameSceneInformation = GameService.get_state()
	var game_string: String = JSON.stringify(game_state, "	")

	# Grab file
	var file_address = FILE_LOCATION + local_save_name + ".json"
	var file = FileAccess.open(file_address, FileAccess.WRITE)

	# Save that bitch!
	file.store_string(game_string)
	file.close()

	save_name = local_save_name

func new_save_file(file_name: String) -> void:
	var save: GameSceneInformation = GameSceneInformation.new()
	save.scene_name = "start"
	save.scene_type = Enum.SceneType.DIALOG
	save.map_events = {}
	save.conditionals = {}

	var file_path = FILE_LOCATION + file_name + ".json"

	if FileAccess.file_exists(file_path):
		print("FILE ALREADY EXISTS [%s]" % file_name)
		return

	var file = FileAccess.open(file_name, FileAccess.WRITE)
	var save_string = JSON.stringify(save, "	")


	file.store_string(save_string)
	save_name = file_name
	GameService.apply_save(save)

func get_save_names() -> Array[String]:
	print("You want to get save names?")
	var dir: DirAccess = DirAccess.open(FILE_LOCATION)
	
	# If no saves 🥺
	if dir == null:
		print("No saves...")
		return []
		
	# Start at beginning of file
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	var response: Array[String] = []
	
	# Keep iterating file names until we run out of file names
	while file_name != "":
		
		# wait... is this a file?
		if dir.current_is_dir() == false:
			# This is a file. Is it a json?
			if file_name.ends_with(".json"):
				response.append(file_name.split(".")[0])
		file_name = dir.get_next()
		
	print("Saves collected [%s]" % response)
	return response

func open_save_menu():
	print("opening save menu...")
	var SaveMenu: Resource = load("res://scenes/menus/SaveMenu.tscn")
	var instance = SaveMenu.instantiate()
	get_tree().root.get_node("Main").add_child(instance)
	instance.visible = true
	instance.position = get_viewport().size / 2

func dict_to_class(dict: Dictionary, object: Object) -> Object:
	if dict == null:
		print("INVALID DICTIONARY! [%s]" % dict)
		return
		
	if object == null:
		print("INVALID OBJECT TO RECEIVE DICT INFORMATION [%s]" % object)
	
	var properties: Array = object.get_property_list()
	
	for key in dict.keys():
		for property in properties:
			if property.name == key:
				object.set(key, dict[key])
				break
	
	return object
