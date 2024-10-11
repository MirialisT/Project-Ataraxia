extends Resource
class_name NPCSpawner

# PROPERTIES SECTION
## Dictionary for handling NPCs, saving for later
var NPC_CONTAINER: Dictionary

# FUNCTIONS SECTION
func spawnNPCs(spawnpoints: Array[Vector2i]):
	for spawnpoint in spawnpoints:
		spawn_npc_at_pos(spawnpoint)
		
func remove_npc_from_list(NPC_UID: int):
	print("CALL::%s::%d" % [remove_npc_from_list, NPC_UID])
	if NPC_CONTAINER.erase(NPC_UID): print("%d erased successfully" % NPC_UID)
	else: print("Cannot erase %d, non-existent" % NPC_UID)
	
func spawn_npc_at_pos(spawnpoint: Vector2i):
	var DNPC = preload("res://Scenes/DynamicNPC.tscn").instantiate()
	var DNPC_UID: int = DNPC.get_rid().get_id()
	DNPC.set_local_pos(spawnpoint)
	print("Saved NPC with UID::%d" % DNPC_UID)
	DNPC.NPC_DEATH.connect(remove_npc_from_list)
	NPC_CONTAINER[DNPC_UID] = DNPC
