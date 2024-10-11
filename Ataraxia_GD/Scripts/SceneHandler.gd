extends Node2D

var NPCSpawnerObject = load("res://Resources/NPCSpawner.tres")
@export var npc_spawn_number: int = 1
## Array of Vector2i(x,y) in local (tilemap) positioning
@export var spawnpoints: Array[Vector2i]

func _init() -> void:
	print("Root initialized")
	if NPCSpawnerObject.NPC_CONTAINER.is_empty(): print("First load of scene")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NPCSpawnerObject.spawnNPCs(spawnpoints)
	addNPCs()

func addNPCs():
	for NPC_object in NPCSpawnerObject.NPC_CONTAINER.values():
		add_child(NPC_object)
