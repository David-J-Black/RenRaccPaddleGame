extends Node

func _init():
	start_quest(
		"Life goal",
		"Hijack a plane and fly it into the new world trade center",
		"test_quest",
		"hijack_plane",
		"Go to the airport and hijack a plane"
	)
	
# Primarily used by the journal menu to load all quests
# The quests will be organized by pool, with the
# pool name as the key
# Value is an array of QuestExtended
func get_all_quests() -> Dictionary:
	var pools: Array[BaseQuestPool] = QuestSystem.get_all_pools()
	var quests: Dictionary = {}
	for pool in pools:
		quests[pool.name] = pool.get_all_quests() as Array[QuestExtended]
	return quests
	

# Check if a quest exists yet
func was_quest_declared(quest_name: String):

	# OOf, nested for loops!
	var pools: Array[BaseQuestPool] = QuestSystem.get_all_pools()
	for pool in pools:
		for quest in pool.get_all_quests():
			if quest.name == quest_name:
				return true
	return false

func start_quest(
	quest_name: String,
	quest_description: String,
	quest_identifier: String,
	objective_name: String,
	objective_description: String
):
	if was_quest_declared(quest_name):
		print("Quest already exists: [%s]" % quest_name)
		return

	var quest: QuestExtended = QuestExtended.new(
		quest_name,
		quest_description,
		quest_identifier,
		objective_name,
		objective_description
	)
	
	QuestSystem.start_quest(quest)

func complete_quest(quest_id: String):
	print("Quest completed: [%s]" % quest_id)
	pass

func load_quests(quests: Dictionary):
	pass

func get_quests() -> Dictionary:
	return QuestSystem.quests_as_dict()

func _on_quest_updated(quest_id: String, quest_data: Dictionary):
	print("Quest updated: [%s]" % quest_id)
	print("Here's the quest data: [%s] as a little treat" % quest_data)
