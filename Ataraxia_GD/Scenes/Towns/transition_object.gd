extends Area2D
class_name TransitionArea
@export var pos_calculation_is_needed: bool = false
@export var scene_switch_to: String
@export var scene_to_spawnpoints: Array[Vector2i]
## Give only two local points: top left and bottom right corner of collision zone.
## It will position itself automatically, given the right coords.
@export var object_collision_corners: Array[Vector2i]
var scene_switch_from: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene_switch_from = get_parent().scene_name
	print("Transition pos: %s" % $CollisionShape2D.position)
	if pos_calculation_is_needed: calculate_position()
	return

func handle_player(player_object: Player) -> void:
	print("%s moving %s to %s" % [self.name, player_object, scene_switch_to])
	print(player_object.get_current_local_pos())

func calculate_position():
	# Comments are for example in Town1 hand-made object to_east
	var tile_size = PositionConverter.t_size
	var half_tile = PositionConverter.ht_size
	var tlc: Vector2i = object_collision_corners[0] # 34:5
	var brc: Vector2i = object_collision_corners[1] # 35:8
	var x_diff: int = absi(tlc.x - brc.x) + 1 # aka size in tiles on x
	var y_diff: int = absi(tlc.y - brc.y) + 1 # aka size in tiles on y
	# The -4 offset is done for collision handling purposes
	var x_size: int = (x_diff * tile_size) - 4
	var y_size: int = (y_diff * tile_size) - 4
	var x_global: int = (tlc.x + brc.x+1) * half_tile # aka size in tiles on x
	var y_global: int = (tlc.y + brc.y+1) * half_tile # aka size in tiles on y
	print("%d %d" % [x_global, y_global])
	var new_shape = RectangleShape2D.new()
	new_shape.size = Vector2(x_size, y_size)
	$CollisionShape2D.position = Vector2(x_global, y_global)
	$CollisionShape2D.shape = new_shape
