extends Area2D
class_name Entity

@export var tile_size = 32
@export var uq_id = 1231245214
@onready var race_controller = $PropertyController/RaceController
@onready var stats_controller = $PropertyController/StatsController
# @onready var body = $PropertyController/BodyController.Body.new()
@onready var race = race_controller.Human.new()
@onready var stats_handler = stats_controller.StatsHandler.new()
#var inputs = {
	#"move_right": Vector2.RIGHT,
	#"move_left": Vector2.LEFT,
	#"move_up": Vector2.UP,
	#"move_down": Vector2.DOWN
	#}
			
# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	stats_handler.get_info()
	print(uq_id)
	print(race.race_name, race.get_race_buffs())

#func _unhandled_input(event):
	#if event.is_action_pressed("Interact"):
		#stats_handler.level_up()
		#var target = $RayCast2D.get_collider()
		#if target != null:
			#print("Hey ",target)
	#for dir in inputs.keys():
		#if event.is_action_pressed(dir):
			#move(dir)

#func collision_handler(direction):
	#var raycast_x = tile_size * inputs[direction][0]
	#var raycast_y = tile_size * inputs[direction][1]
	#$RayCast2D.target_position = Vector2(raycast_x, raycast_y)
	#$RayCast2D.force_raycast_update()
	#return !$RayCast2D.is_colliding()
		
#func move(dir):
	#stats_handler.get_info()
	#if collision_handler(dir):
		#position += inputs[dir] * tile_size
