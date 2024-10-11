extends Node2D

var NPCSpawnerObject = load("res://Resources/NPCSpawner.tres")
var SCENE_NPCS: Dictionary
var last_time_visited: int = 0
# @export var SCENE_NAME: String
@export var npc_spawn_number: int = 1
@export var Scene_name: String = "Scene_name_placeholder"
## In TileMap coordinates
@export var spawnpoints: Array[Vector2i]

func _init() -> void: print("Scene initialized")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
