extends Area2D
class_name Entity

@export var npc_name = "changeme"
@export var tile_size = 32
@onready var race = $PropertyController/RaceController.Human.new()
@onready var stats_handler = $PropertyController/StatsController.StatsHandler.new()
@onready var body = $PropertyController/BodyController.Body.new()
#var inputs = {
	#"move_right": Vector2.RIGHT,
	#"move_left": Vector2.LEFT,
	#"move_up": Vector2.UP,
	#"move_down": Vector2.DOWN
	#}
			
# Called when the node enters the scene tree for the first time.
func handle_damage(damage_amount: int):
	$hbar.value = stats_handler.damage(damage_amount)
	
func get_hit(bodypart_name: String, damage_amount: int, bleed_severity: int):
	print("%s got hit by player in %s by %d with bleed severity %d" % [npc_name, bodypart_name, damage_amount, bleed_severity])
	body.bodypart_get_hit(bodypart_name, 5, 1)
	
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	stats_handler.get_info()
	print(race.race_name, npc_name, race.get_race_buffs())
	print("\n")
	$hbar.value = stats_handler.get_health()

#func _process(_delta) -> void:
	#if !stats_handler.is_alive: queue_free()
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
