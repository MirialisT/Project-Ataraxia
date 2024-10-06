extends Area2D
class_name Player

@export var tile_size = 32
@onready var race = $PropertyController/RaceController.Human.new()
@onready var body = $PropertyController/BodyController.Body.new()
@onready var stats_handler = $PropertyController/StatsController.StatsHandler.new()
# signal time_process(time_amount: int)
# maybe try singleton time processer?
# change time on user input (move, action)
# ALT1: _unhandled_input progresses time for NPCs&World?
# ALT2: _unhandled_input CALLS time to process things
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
	}
			
# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	stats_handler.modify_stats(race.get_race_buffs())
	print("%s player, level %d, spare points %d" % [race.race_name, stats_handler.level, stats_handler.spare_points])
	print("Current race buffs: ", race.get_race_buffs())
	print("Current stats: ", stats_handler.get_stats_dict())
	print("%d/%d" % [body.get_max_health(), body.get_current_health()])
	print("\n")

func _unhandled_input(event):
	# this catches mouse too, need to handle
	# time_process.emit(5)
	var target = $RayCast2D.get_collider()
	if event.is_action_pressed("DEBUG_TRIGGER_COMBAT"):
		if target != null and target is Entity and target.body.is_alive: initiate_combat(target)
	if event.is_action_pressed("Interact"):
		if target != null: initiate_interaction(target)
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			$Combat.set_visible(false)
			move(dir)
			
func initiate_combat(target: Entity):
	# change combat to completely separate scene, or make whole overlay
	$Combat.enemy_object = target
	$Combat.prepare()
	$Combat.set_visible(true)

func initiate_interaction(target: Entity):
	print("It can be alive, either NPC or beast")
	if target.npc_name != null: print("Hey, it's has name, hello %s %s!" % [target.race.race_name, target.npc_name])
	if target.body.is_alive: print("Oh, it's actually alive, has %d health." % target.body.get_current_health())
	else: print("It's already dead...")
	if target.body.is_consious: print("It can react to my actions.")
	else: print("It can not react to my actions.")
	

func collision_handler(direction):
	var raycast_x = tile_size * inputs[direction][0]
	var raycast_y = tile_size * inputs[direction][1]
	$RayCast2D.target_position = Vector2(raycast_x, raycast_y)
	$RayCast2D.force_raycast_update()
	return !$RayCast2D.is_colliding()
		
func move(dir):
	if collision_handler(dir):
		position += inputs[dir] * tile_size
