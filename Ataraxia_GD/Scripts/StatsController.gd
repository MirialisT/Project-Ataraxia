extends Node
class StatsHandler:
	var spare_points: int = 0
	var level: int = 0
	var stats = { # separate interface for uplevel picking
		"STR" = 0,
		"AGI" = 0,
		"MAG" = 0,
		"WIT" = 0,
		"CON" = 0,
		"CHR" = 0
	}
	func get_stat_int(stat_name): return stats[stat_name]
	func get_stats_dict(): return stats
	func modify_stats(m_stats: Dictionary):
		for stat in m_stats.keys():
			stats[stat] += m_stats[stat]
	
	func level_up():
		level += 1
		spare_points += 1

	func _init():
		level_up()
	
