extends Area2D
class_name Player

@export var tile_size = 32
@onready var race = $PropertyController/RaceController.Human.new()
@onready var body = $PropertyController/BodyController.Body.new()
@onready var stats_handler = $PropertyController/StatsController.StatsHandler.new()
# TODO: systems:
# Inventory (for both PC and NPC)
# UPD1: Items (only basic): do it via Resources, check link on side for info
# 	Armor upd: handle with Resource class, damage process is still to come up with
# Weapons with different damage type (blunt, cut and pierce for now)
#	-||- with armor and items, Resource -> class name handling?
var in_combat: bool = false
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
	}
			
func _ready():
	fix_position()
	stats_handler.modify_stats(race.get_race_buffs())
	body.apply_buffs_and_reset(stats_handler.get_stat_int("CON"))
	print("%s player, level %d, spare points %d" % [race.race_name, stats_handler.level, stats_handler.spare_points])
	print("Current race buffs: ", race.get_race_buffs())
	print("Current stats: ", stats_handler.get_stats_dict())
	print("%d/%d" % [body.get_max_health(), body.get_current_health()])
	print("\n")

func _unhandled_input(event):
	# this catches mouse too, need to handle
	# ignores mouse -> ignores mouse+keyboard
	# print("In-combat:%s" % in_combat, event)
	if !in_combat:
		var target = $RayCast2D.get_collider()
		if target is NPC: $UI.visible = true
		else: $UI.visible = false
		if event.is_action_pressed("DEBUG_TRIGGER_COMBAT"):
			if target != null and target is NPC and target.body.is_alive: initiate_combat(target)
		if event.is_action_pressed("Interact"):
			if target != null and target is NPC: initiate_interaction(target)
	for dir in inputs.keys():
		# Do not touch for now, solved key ghosting after fight
		if in_combat:
			if event.is_action(dir):
				# print("Got movement from is_action: %s" % dir)
				stop_combat()
				move(dir)
		else:
			if event.is_action_pressed(dir):
				# print("Got movement %s" % dir)
				move(dir)
			
func initiate_combat(target: NPC):
	# TODO: change combat to completely separate scene, or make whole overlay
	$Combat.enemy_object = target
	$Combat.player_object = self
	in_combat = true
	$Combat.prepare()
	$Combat.set_visible(true)

func stop_combat():
	print("Leaving combat")
	$Combat.set_visible(false)
	in_combat = false

func initiate_interaction(target: NPC):
	var target_3d: String = target.pronouns["third_face"]
	var target_ps: String = target.pronouns["possesive"]
	print("It can be alive, either NPC or beast")
	if target.npc_name != null:
		print("Hey, it's %s, %s name is %s!" % [target.race.race_name, target_ps, target.npc_name])
	if target.body.is_alive:
		print("Oh, %s is actually alive, has %d health." % [target_3d, target.body.get_current_health()])
	else: print("Well, %s is already dead..." % target_3d)
	if target.body.is_consious: print("%s can react to my actions." % target_3d.capitalize())
	else: print("%s can not react to my actions." % target_3d.capitalize())
	print("Ping - %s: %s" % [target.npc_name, target.ping()])
	

func collision_handler(direction):
	var raycast_x = tile_size * inputs[direction][0]
	var raycast_y = tile_size * inputs[direction][1]
	$RayCast2D.target_position = Vector2(raycast_x, raycast_y)
	$RayCast2D.force_raycast_update()
	return !$RayCast2D.is_colliding()
		
func move(dir):
	if collision_handler(dir):
		TimeProcesser.DEBUG_LOG(5)
		position += inputs[dir] * tile_size
		
func fix_position():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

# Split positioning into global script
func set_local_pos(local_points: Vector2i):
	position = local_to_global_pos(local_points)
	return self
	
func local_to_global_pos(local_points: Vector2i):
	return Vector2i((local_points.x*32 + 16), (local_points.y*32 + 16))
