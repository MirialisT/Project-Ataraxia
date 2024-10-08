extends Area2D
class_name NPC
var money: int = 100
var state_corpse: bool = false
@export var corpse_decay_time: int = 200
var corpse_decaying_timer = 0
var pronouns: Dictionary = {
	"third_face": "3rd_placeholder",
	"possesive": "poss_placeholder"
}

func fix_position():
	if int(position.x) % 32 == int(position.y) % 32 and int(position.x) % 32 == 16: return
	var local_pos = global_to_local_pos()
	print("LOCAL: %s" % local_pos)
	position = local_to_global_pos(local_pos)
	print("GLOBAL: %s" % position)

func global_to_local_pos():
	return Vector2i(round((position.x - 16)/32), round((position.y - 16)/32))

func local_to_global_pos(local_points: Vector2i):
	return Vector2i((local_points.x*32 + 16), (local_points.y*32 + 16))

func set_local_pos(local_points: Vector2i):
	position = local_to_global_pos(local_points)
	return self
