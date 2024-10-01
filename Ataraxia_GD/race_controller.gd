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
	func get_stats():
		return stat_buffs

class Human extends BasicRace:
	func _init():
		race_name = "human"
		stat_buffs["CHR"] += 1
		stat_buffs["MAG"] -= 1

func get_race(race_name):
	if race_name == "human": return Human.new()
