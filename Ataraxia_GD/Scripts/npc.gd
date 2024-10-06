extends Area2D
class_name Entity

@export var npc_name = "changeme"
@export var race_name = "changeme"
@export var tile_size = 32
@onready var race = $PropertyController/RaceController.get_race(race_name, npc_name)
@onready var stats_handler = $PropertyController/StatsController.StatsHandler.new()
@onready var body = $PropertyController/BodyController.Body.new()
#var inputs = {
	#"move_right": Vector2.RIGHT,
	#"move_left": Vector2.LEFT,
	#"move_up": Vector2.UP,
	#"move_down": Vector2.DOWN
	#}
			
func get_hit(bodypart_name: String, damage_amount: int, bleed_severity: int):
	print("%s got hit by player in %s by %d with bleed severity %d" % [npc_name, bodypart_name, damage_amount, bleed_severity])
	body.bodypart_get_hit(bodypart_name, damage_amount, bleed_severity)
	if !body.is_alive: handle_death()
	else: update_hbar()
	
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	stats_handler.modify_stats(race.get_race_buffs())
	$hbar.max_value = body.get_max_health()
	print("%s %s, level %d, spare points %d" % [race.race_name, npc_name, stats_handler.level, stats_handler.spare_points])
	print("Current race buffs: ", race.get_race_buffs())
	print("Current stats: ", stats_handler.get_stats_dict())
	print("%d/%d" % [body.get_max_health(), body.get_current_health()])
	update_hbar()
	print("\n")

func handle_death():
	$hbar.queue_free()

func update_hbar():
	$hbar.value = body.get_current_health()

func ping():
	if body.is_consious: return "Pong"
	else: return "silence"
#func _process(_delta) -> void:
	#if !stats_handler.is_alive: queue_free()

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
