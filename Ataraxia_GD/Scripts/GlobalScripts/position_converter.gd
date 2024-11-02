extends Node

func check_pos(position: Vector2) -> bool:
	return int(position.x) % 32 == int(position.y) % 32 and int(position.x) % 32 == 16
	
func local_to_global_pos(local_points: Vector2i):
	return Vector2i((local_points.x*32 + 16), (local_points.y*32 + 16))
	
func global_to_local_pos(position: Vector2):
	return Vector2i(round((position.x - 16)/32), round((position.y - 16)/32))
