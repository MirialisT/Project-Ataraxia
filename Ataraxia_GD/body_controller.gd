extends Node

class BodyPart:
	var is_intact: bool = true
	var bp_name = "placeholder_name"
	var bp_health: int = 100
	func _init(bodypart_name):
		bp_name = bodypart_name
	func take_damage(damage: int):
		bp_health -= damage
		if bp_health <= 0:
			bp_health = 0
			is_intact = false
	
class Body:
	var bodyparts_container = {
		"bodypart_HEAD": BodyPart.new("head"),
		"bodypart_TORSO": BodyPart.new("torso"),
		"bodypart_LHAND": BodyPart.new("lefthand"),
		"bodypart_RHAND": BodyPart.new("righthand"),
		"bodypart_LLEG": BodyPart.new("leftleg"),
		"bodypart_RLEG": BodyPart.new("rightleg")
	}
