extends Control
@export var enemy_object: Entity
@export var player_object: Player
func _ready() -> void:
	pass


func _on_enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int) -> void:
	enemy_object.get_hit(bodypart_name, damage_amount, bleed_severity)
	# TODO: change battle logic
	# options with enemy_object.body.bodypart_get_hit?
	# check for handle_death() and other logic
	# handle death & UI update here?
	if not enemy_object.body.get_bodypart_status(bodypart_name): enemy_part_destroyed(bodypart_name)
	if not enemy_object.body.is_alive:
		self.visible = false
		player_object.in_combat = false
	
func enemy_part_destroyed(bodypart_name: String):
	 #print("Call %s" % self.enemy_part_destroyed)
	for part in $Enemy.get_children():
		if part.bodypart_name == bodypart_name:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
# TODO: battle-system related
# switch to turn-based system, handle the bleeding with it for now
func prepare():
	print("Fighting %s" % enemy_object.npc_name)
	for part in $Enemy.get_children():
		if enemy_object.body.get_bodypart_status(part.bodypart_name):
			part.set_self_modulate(Color(1, 1, 1, 1))
		else:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
