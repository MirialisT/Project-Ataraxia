extends Area2D
class_name Character
@export var money: int = 100
@export var corpse_decay_time: int = 200
@export var tile_size = 32
var state_corpse: bool = false
var corpse_decaying_timer = 0
var pronouns: Dictionary = {
	"third_face": "3rd_placeholder",
	"possesive": "poss_placeholder"
}
