extends Node
signal process_time(time_amount: int)
signal bleed_on_time()
@export var start_time: int
# store time from last time visited, check DNPC script
func DEBUG_LOG(int_time: int):
	print("DEBUG::increase_time_by_%d" % int_time)
	process_time.emit(5)
	bleed_on_time.emit()
