extends Area2D
class_name Character
@export var money: int = 100
@export var corpse_decay_time: int = 200
var tile_size = PositionConverter.t_size
var paired_state: bool = false
var state_corpse: bool = false
var corpse_decaying_timer = 0
var pronouns: Dictionary = {
	"third_face": "3rd_placeholder",
	"possesive": "poss_placeholder"
}

func pair_offset(_caller: Area2D = null) -> void:
	$Sprite2D.offset.x = 15
	paired_state = true
func pair_offset_restore(_caller: Area2D = null) -> void:
	$Sprite2D.offset.x = 0
	paired_state = false

func get_current_local_pos() -> Vector2i:
	return PositionConverter.global_to_local_pos(self.position)
