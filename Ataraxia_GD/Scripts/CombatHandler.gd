extends Control
# Called when the node enters the scene tree for the first time.
@export var enemy_object: Entity
@export var player_object: Player
func _ready() -> void:
	pass # Replace with function body.


func _on_enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int) -> void:
	enemy_object.get_hit(bodypart_name, damage_amount, bleed_severity)
	if not enemy_object.body.get_bodypart_status(bodypart_name): enemy_part_destroyed(bodypart_name)
	if not enemy_object.body.is_alive:
		self.visible = false
		player_object.in_combat = false
	
func enemy_part_destroyed(bodypart_name: String):
	 #print("Call %s" % self.enemy_part_destroyed)
	for part in $Enemy.get_children():
		if part.bodypart_name == bodypart_name:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
#Hitting part torso by 5 with 0 bleed severity
#Alex got hit by player in torso by 5 with bleed severity 0
#Bodypart torso is broken, not bleeding
#BodyPart:torso:0:true:false:0
#InputEventKey: keycode=4194322 (Down), mods=none, physical=false, location=unspecified, pressed=false, echo=false
#InputEventKey: keycode=4194322 (Down), mods=none, physical=false, location=unspecified, pressed=true, echo=false
#Got movement move_down
#Leaving combat
func prepare():
	print("Fighting %s" % enemy_object.npc_name)
	for part in $Enemy.get_children():
		if enemy_object.body.get_bodypart_status(part.bodypart_name):
			part.set_self_modulate(Color(1, 1, 1, 1))
		else:
			part.set_self_modulate(Color(1, 1, 1, 0.25))
