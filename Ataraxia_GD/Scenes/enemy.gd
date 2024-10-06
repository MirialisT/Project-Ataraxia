extends Node

@onready var enemy_bodyparts: Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_enemy_body(enemy_bps: Dictionary):
	print("Called set_enemy_body with %s" % enemy_bps)
	enemy_bodyparts = enemy_bps
	set_bodyparts()

func set_bodyparts():
	pass
	#$Combat/BattlerContainer/Enemy/Head.bodypart = enemy_bodyparts["head"]
	
