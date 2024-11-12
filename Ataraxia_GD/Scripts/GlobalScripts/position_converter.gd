extends Node
var t_size = 32
var ht_size = 16
func check_pos(position: Vector2) -> bool:
	return int(position.x) % t_size == int(position.y) % t_size and int(position.x) % t_size == ht_size
	
func local_to_global_pos(local_points: Vector2i):
	return Vector2i((local_points.x*t_size + ht_size), (local_points.y*t_size + ht_size))
	
func global_to_local_pos(position: Vector2):
	return Vector2i(round((position.x - ht_size)/t_size), round((position.y - ht_size)/t_size))
