extends Node

class BasicRace:
	var stat_buffs = {
		"STR" = 0,
		"AGI" = 0,
		"MAG" = 0,
		"WIT" = 0,
		"CON" = 0,
		"CHR" = 0
	}
	var race_name = "basic_race"
	func get_race_buffs(): return stat_buffs
# Make universal class to support both static and dynamic npc creation only with passed data
#class BasicBeast extends BasicRace:
	#func _init():
		#race_name = "BasicBeast"
		#
#class MagicBeast extends BasicBeast:
	#func _init():
		#race_name = "MagicBeast"
		#stat_buffs["MAG"] += 2
		#stat_buffs["WIT"] += 2
		#stat_buffs["STR"] -= 2
#
#class FeralBeast extends BasicBeast:
	#func _init():
		#race_name = "FeralBeast"
		#stat_buffs["MAG"] -= 2
		#stat_buffs["WIT"] -= 2
		#stat_buffs["STR"] += 2
		
class Human extends BasicRace:
	func _init():
		race_name = "Human"

class BeastMan extends BasicRace:
	func _init():
		race_name = "BeastMan"
		stat_buffs["STR"] += 2
		stat_buffs["CON"] += 2
		stat_buffs["WIT"] -= 2
		
class HalfElf extends Human:
	func _init():
		race_name = "HalfElf"
		stat_buffs["AGI"] += 1
		stat_buffs["CON"] -= 2
		
class Elf extends BasicRace:
	func _init():
		race_name = "Elf"
		stat_buffs["AGI"] += 2
		stat_buffs["STR"] -= 1

class HighElf extends Elf:
	func _init():
		race_name = "HighElf"
		stat_buffs["MAG"] += 3
		stat_buffs["WIT"] += 2
		
func get_race(race_name: String, entity_name: String = "player"):
	match race_name:
		"Human": return Human.new()
		"Elf": return Elf.new()
		"HighElf": return HighElf.new()
		"HalfElf": return HalfElf.new()
		"BeastMan": return BeastMan.new()
		_:
			print("WARNING: NPC %s got BasicRace, check for race typo!" % entity_name)
			return BasicRace.new()
