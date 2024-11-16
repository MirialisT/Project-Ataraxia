extends Node
enum CurrentRoutine {IDLE, MOVE, WORK, REST}
@export var current_routine: CurrentRoutine
@onready var navigator = $NavigationController

func switch_routine(routine_id: int) -> void: current_routine = routine_id

func process_routine() -> void:
	match current_routine:
		0: return
		1: move()
		2: work()
	pass

func move():
	navigator.move()
func work():
	print("WORK")
