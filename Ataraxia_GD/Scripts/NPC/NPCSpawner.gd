extends Node2D
@export var npc_spawn_number: int = 1
@export var spawnpoints: Array[Vector2i]
func _init() -> void:
	print("Root initialized")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for spawnpoint in spawnpoints:
		spawn_npc_at_pos(spawnpoint)
# TODO: move NPCSpawner into separate resource
func spawn_npc_at_pos(spawnpoint: Vector2i):
	var DNPC = preload("res://Scenes/DynamicNPC.tscn").instantiate()
	add_child(DNPC.set_local_pos(spawnpoint))
