extends Control
# Called when the node enters the scene tree for the first time.
@export var enemy_object: Entity
@export var player_object: Player
func _ready() -> void:
	pass # Replace with function body.


func _on_enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int) -> void:
	enemy_object.get_hit(bodypart_name, damage_amount, bleed_severity)
	if not enemy_object.body.get_bodypart_status(bodypart_name): enemy_part_destroyed(bodypart_name)
	if not enemy_object.body.is_alive: self.visible = false
	
func enemy_part_destroyed(bodypart_name: String):
	for part in $Enemy.get_children():
		if part.bodypart_name == bodypart_name:
			print(part.get_self_modulate())
			part.set_self_modulate(Color(1, 1, 1, 0.25))

func prepare():
	print("Fighting %s" % enemy_object.npc_name)
	for part in $Enemy.get_children():
		if enemy_object.body.get_bodypart_status(part.bodypart_name):
			part.set_self_modulate(Color(1, 1, 1, 1))
		else:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
