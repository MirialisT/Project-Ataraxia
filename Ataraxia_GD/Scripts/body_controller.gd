extends Node

class BodyPart:
	var is_intact: bool = true
	var bp_name = "placeholder_name"
	var bp_health: int = 100
	# For later: mix health system with hemorrhage, get wounds with health_dmg + wound_severity
	func _init(bodypart_name):
		bp_name = bodypart_name
		log_stat()
	func take_damage(damage: int):
		bp_health -= damage
		if bp_health <= 0:
			bp_health = 0
			is_intact = false
	#*
	func log_stat():
		print("BodyPart:%s:%d:%s" % [bp_name, bp_health, is_intact])
	
class Body:
	var bodyparts_container = {
		"head": BodyPart.new("head"),
		"torso": BodyPart.new("torso"),
		"lefthand": BodyPart.new("lefthand"),
		"righthand": BodyPart.new("righthand"),
		"leftleg": BodyPart.new("leftleg"),
		"rightleg": BodyPart.new("rightleg")
	}
	func bodypart_get_hit(bodypart_name, damage_amount: int):
		bodyparts_container[bodypart_name].take_damage(damage_amount)
