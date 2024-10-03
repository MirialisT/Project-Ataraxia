extends Node
# This is both stats and health controller, so yeah, im lazy
class StatsHandler:
	var is_alive: bool = true
	var basic_health: int = 100
	var current_health: int = 1
	var max_health: int
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
	
	func level_up():
		level += 1
		spare_points += 1
		handle_health()
		#handle leveling with separate interface
		
	func handle_health():
		max_health = basic_health * (level + stats["CON"])
		current_health = max_health
		
	func get_health(): return current_health
	func heal(heal: int): current_health += heal
	func restore_health(): current_health = max_health
	func damage(damage: int):
		current_health -= damage
		if current_health <= 0:
			current_health = 0
			is_alive = false
			print("DEAD")
	func is_alive_check(): return is_alive
	func get_info():
		print("Current health: %d, max health: %d, level: %d, spare points: %d" % [current_health, max_health, level, spare_points])
		print(stats)
		
	func _init():
		level_up()
	
