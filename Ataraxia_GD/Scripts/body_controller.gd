extends Node

class BodyPart:
	var is_intact: bool = true
	var is_not_broken: bool = true
	var wound_severity: int = 0
	var bp_name = "placeholder_name"
	var bp_health: int = 50
	# For later: mix health system with hemorrhage, get wounds with health_dmg + wound_severity

	func _init(bodypart_name):
		bp_name = bodypart_name
		log_stat()
	func take_damage(damage: int, bleed_severity):
		bp_health -= damage
		if bleed_severity: wound_severity = bleed_severity
		if bp_health <= 0:
			bp_health = 0
			if wound_severity:
				is_intact = false
				wound_severity = 4
				print("Bodypart %s is cut off, bleeding with %d severity." % [bp_name, wound_severity])
			else:
				is_not_broken = false
				print("Bodypart %s is broken, not bleeding" % [bp_name])
	func log_stat():
		print("BodyPart:%s:%d:%s:%s:%d" % [bp_name, bp_health, is_intact, is_not_broken, wound_severity])
	
class Body:
	var sex
	var bodyparts_container = {
	# handle eyes, parts that are not intact affect stats + parser description
		"head": BodyPart.new("head"),
		"torso": BodyPart.new("torso"),
		"lefthand": BodyPart.new("lefthand"),
		"righthand": BodyPart.new("righthand"),
		"leftleg": BodyPart.new("leftleg"),
		"rightleg": BodyPart.new("rightleg")
	}
	func get_total_health():
		var total_hp = 0
		for part in bodyparts_container.values():
			total_hp += part.bp_health
		return total_hp
		
	func bodypart_get_hit(bodypart_name, damage_amount: int, bleed_severity: int = 0):
		var target_bp = bodyparts_container[bodypart_name]
		if target_bp.is_intact and target_bp.is_not_broken:
			target_bp.take_damage(damage_amount, bleed_severity)
		else: print("Bodypart %s is already missing or broken." % bodypart_name)
		target_bp.log_stat()
