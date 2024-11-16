extends Node
@export_enum("IDLE", "MOVE", "WORK", "REST") var current_routine: String = "IDLE"

func switch_routine(new_routine: String) -> void:
	if current_routine.contains(new_routine): current_routine = new_routine
