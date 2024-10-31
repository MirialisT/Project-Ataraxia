extends Node
signal process_time(time_amount: int)
const year_to_ticks: int = 73728
var start_time: int = 0
var global_time: int = 0
var day_time: int = 0
var hour: int = 0
var minute: int = 0
var day: int = 0
# store time from last time visited, check DNPC script
# write new functions, fix this shit
func _init() -> void: print("Time processer init called")
func time_process(int_time: int = 5):
	print("DEBUG::increase_time_by_%d" % int_time)
	global_time += int_time
	print("GLOBAL_TIME::%d" % global_time)
	process_day_cicle(int_time)
	process_time.emit(int_time)

func time_to_ticks(time_amount: int) -> int: return int(time_amount/5.0)

func process_day_cicle(time: int):
	day_time += time
	hour = day_time/60
	minute = day_time%60
	day += day_time/(60*24)
	if hour >= 24: day_reset()
	print("Current time: Day %d, %s %02d:%02d" % [day,get_daycycle_state(), hour, minute])
	pass

func day_reset():
	day_time = 0
	hour = 0
	minute = 0
	day += 1

func get_daycycle_state() -> String:
	if hour < 4: return "Night"
	if hour < 12: return "Morning"
	if hour < 18: return "Noon"
	if hour < 24: return "Dusk"
	else: return "Night"
