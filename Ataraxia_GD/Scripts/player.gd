extends Character
class_name Player

@onready var race = $PropertyController/RaceController.Human.new()
@onready var body = $PropertyController/BodyController.Body.new()
@onready var stats_handler = $PropertyController/StatsController.StatsHandler.new()
# TODO: systems:
# Inventory (for both PC and NPC)
# UPD1: Items (only basic): do it via Resources, check link
# https://www.youtube.com/watch?v=nR0nCFJ8-qM
# 	Armor upd: handle with Resource class, damage process is still to come up with
# Weapons with different damage type (blunt, cut and pierce for now)
#	-||- with armor and items, Resource -> class name handling?
# UPD2: Armor\weapon damage solution: armor\weapon class
var in_combat: bool = false
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
	}
# check for community inventory solutions
#	prolly separate scene added to player, maybe another resource?, global script sounds meh?
# A ton of Resource's for every item in game \ dynamic generation?
var inventory: Dictionary
func _ready():
	#area_entered.connect(log_area)
	fix_position()
	stats_handler.modify_stats(race.get_race_buffs())
	body.apply_buffs_and_reset(stats_handler.get_stat_int("CON"))
	print("%s player, level %d, spare points %d" % [race.race_name, stats_handler.level, stats_handler.spare_points])
	print("Current race buffs: ", race.get_race_buffs())
	print("Current stats: ", stats_handler.get_stats_dict())
	print("%d/%d" % [body.get_max_health(), body.get_current_health()])
	print("\n")
	# Looks horrible, need an item spawner asap. Works though.
	inventory[load("res://Resources/BasicItem.tres")] = 1
	for item in inventory.keys(): item.DEBUG()

func log_area(received_area: Area2D): print(received_area)
func show_actions(state: bool):
	$UI/Actions.visible = state
func _unhandled_input(event):
	show_actions(false)
	# this catches mouse too, need to handle
	# ignores mouse -> ignores mouse+keyboard
	# print("In-combat:%s" % in_combat, event)
	if !in_combat:
		var target = $RayCast2D.get_collider()
		# Think about on-enter-scene-switch approach
		# Prolly interactable objects with scene_to String
		#if target is TileMapLayer:
			#var tile_data: TileData = target.get_cell_tile_data(target.global_position)
			#print(tile_data.get_custom_data("scene_move_to"))
		if target is Character:
			show_actions(true)
			if event.is_action_pressed("DEBUG_TRIGGER_COMBAT"):
				if target != null and target is Character and target.body.is_alive: initiate_combat(target)
			if event.is_action_pressed("Interact"):
				if target != null and target is Character: initiate_interaction(target)
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
			
func initiate_combat(target: Character):
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

func initiate_interaction(target: Character):
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
		TimeProcesser.time_process(5)
		position += inputs[dir] * tile_size
		
# Split positioning into global, universal script
# check for BasicNPC, NPCSpawner
func fix_position() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
#func set_local_pos(local_points: Vector2i):
	#position = local_to_global_pos(local_points)
	#return self # Dafuq? It's not even used. Okay, it's technically depricated for player, but used for DNPC in NPCSpawner
func local_to_global_pos(local_points: Vector2i) -> Vector2i:
	return Vector2i((local_points.x*32 + 16), (local_points.y*32 + 16))
