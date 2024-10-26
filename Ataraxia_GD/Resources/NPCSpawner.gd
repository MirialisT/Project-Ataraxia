extends Resource
class_name NPCSpawner

# PROPERTIES SECTION
## Dictionary for handling NPCs, saving for later
var NPCGenerator = load("res://Resources/DynamicNPCGenerator.tres")

# FUNCTIONS SECTION
func spawnNPCs(spawnpoints: Array[Vector2i]):
	var DNPC_CONTAINER: Dictionary
	var DNPC: NPC
	var DNPC_UID: int
	var spawnedNPC: NPC
	for spawnpoint in spawnpoints:
		DNPC = preload("res://Scenes/DynamicNPC.tscn").instantiate()
		DNPC_UID = DNPC.get_rid().get_id()
		spawnedNPC = spawn_npc_at_pos(DNPC, DNPC_UID, spawnpoint)
		spawnedNPC.npc_uid = DNPC_UID
		print("%s::saved NPC with %d UID" % [spawnNPCs, DNPC_UID])
		DNPC_CONTAINER[DNPC_UID] = spawnedNPC
	return DNPC_CONTAINER

func spawn_npc_at_pos(DNPC: NPC, DNPC_UID: int, spawnpoint: Vector2i):
	print("%s:%s:%d:%s" % [spawn_npc_at_pos, DNPC, DNPC_UID, spawnpoint])
	var generated_npc: Array = NPCGenerator.generate_npc()
	DNPC.sex = generated_npc[1]
	DNPC.race_name = generated_npc[0]
	DNPC.npc_name = generated_npc[2]
	DNPC.name = str(DNPC_UID)
	DNPC.set_local_pos(spawnpoint)
	return DNPC
