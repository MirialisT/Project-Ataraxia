extends Control
var enemy_object: Character
var player_object: Player
func _ready() -> void:
	pass

# Switch to global combat handler? Prolly better, not fixated on player pos and stuff, just pass nodes

func _on_enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int) -> void:
	enemy_object.get_hit(bodypart_name, damage_amount, bleed_severity)
	# rework ticks
	TimeProcesser.time_process(5)
	if not enemy_object.body.get_bodypart_status(bodypart_name): enemy_part_destroyed(bodypart_name)

func enemy_killed(enemy_uid: int):
	print("Killed %d" % enemy_uid)
	self.visible = false

func enemy_part_destroyed(bodypart_name: String):
	for part in $Enemy.get_children():
		if part.bodypart_name == bodypart_name:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
# TODO: battle-system related
# switch to turn-based system, handle the bleeding with it for now
func prepare():
	print("Fighting %s" % enemy_object.npc_name)
	#enemy_object.NPC_DEATH.connect(enemy_killed)
	for part in $Enemy.get_children():
		if enemy_object.body.get_bodypart_status(part.bodypart_name):
			part.set_self_modulate(Color(1, 1, 1, 1))
		else:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
