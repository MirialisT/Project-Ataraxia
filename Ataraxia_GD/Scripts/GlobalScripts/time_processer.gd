extends Node
signal process_time(time_amount: int)
var start_time: int
var global_time: int = 0
# store time from last time visited, check DNPC script
# write new functions, fix this shit
func DEBUG_LOG(int_time: int):
	print("DEBUG::increase_time_by_%d" % int_time)
	print("GLOBAL_TIME::%d" % global_time)
	process_time.emit(5)
	global_time += 5
