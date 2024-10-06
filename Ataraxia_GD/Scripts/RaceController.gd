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

class Human extends BasicRace:
	func _init():
		race_name = "Human"
		stat_buffs["CHR"] += 1
		stat_buffs["MAG"] -= 1

class Elf extends BasicRace:
	func _init():
		race_name = "Elf"
		stat_buffs["AGI"] += 1
		stat_buffs["STR"] -= 1

func get_race(race_name: String, entity_name: String = "player"):
	match race_name:
		"Human": return Human.new()
		"Elf": return Elf.new()
		_:
			print("WARNING: NPC %s got BasicRace, check for race typo!" % entity_name)
			return BasicRace.new()
