extends Node2D
class_name SceneHandler
var NPCSpawnerObject = load("res://Resources/NPCSpawner.tres")
var SCENE_NPCS: Dictionary
var inactive_time: int = 0
var inactive: bool = true
# @export var SCENE_NAME: String
@export var npc_spawn_number: int = 1
@export var Scene_name: String = "Scene_name_placeholder"
@export var player_spawnpoint: Vector2i = Vector2i(17,7)
## In TileMap coordinates
@export var spawnpoints: Array[Vector2i]
signal npc_process_time(int)
func _init() -> void: print("Scene initialized")
# TODO: long, make houses as sub scenes for town, handle entering-leaving
func _ready() -> void:
	TimeProcesser.process_time.connect(process_global_time)
	print("%s::%s" % [name, _ready])
	if SCENE_NPCS.is_empty():
		print("First load of scene, generating NPCs")
		SCENE_NPCS = NPCSpawnerObject.spawnNPCs(spawnpoints)
	else:
		print("Entering the scene, loading NPCs from save")
		# do this after making save-load for scenes
	addNPCs()

func addNPCs():
	for NPC_object in SCENE_NPCS.values():
		NPC_object.NPC_DEATH.connect(removeNPC)
		add_child(NPC_object)

func removeNPC(NPC_UID: int):
	print("CALL::%s::%d" % [removeNPC, NPC_UID])
	if SCENE_NPCS.erase(NPC_UID): print("%d erased successfully" % NPC_UID)
	else: print("Cannot erase %d, non-existent" % NPC_UID)
	
func spawn_player(player_object: Node = null):
	if player_object == null: player_object = preload("res://Scenes/player.tscn").instantiate()
	add_child(player_object)
	player_object.position = player_object.local_to_global_pos(player_spawnpoint)

func unload_player() -> Node2D:
	var player_node: Node = get_node("player")
	remove_child(player_node)
	return player_node
	
func process_global_time(global_time_tick: int = 0):
	if inactive:
		inactive_time += global_time_tick
		print("%s: Inactive time accumulated: %d" % [name, inactive_time])
	else:
		if inactive_time > 0:
			print("%s scene processing accumulated time of %d" % [name, inactive_time])
			process_active_time(inactive_time)
			inactive_time = 0
			return
		process_active_time(global_time_tick)

func process_active_time(time_to_process: int):
	print("%s is processing time: %d" % [name, time_to_process])
	npc_process_time.emit(time_to_process)
