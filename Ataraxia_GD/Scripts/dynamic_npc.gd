extends NPC
# TODO: Big things, FOCUS ON NPC first
# JobDriver class \ resource, occupations
# Skills for both player and NPCs
# DNPC generator for region\town root, consider race habitat and amount + paths
# Save dynamic NPC to dynamic-to-static npc dictionary and save as scene state
# accumulate time from last time scene visited and calculate progress on diff
# Event and Quest systems for both DNPC and SNPC
var npc_name: String
var sex: String
var race_name: String
@export var tile_size = 32
@onready var race
@onready var stats_handler = $PropertyController/StatsController.StatsHandler.new()
@onready var body = $PropertyController/BodyController.Body.new()
var NPCGenerator = load("res://Resources/DynamicNPCGenerator.tres")

func _init() -> void: print("DNPC is initiated")
#func DEBUG() -> void: print("NPC %s is spawned via NPCSpawner" % npc_name)
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

func _mouse_enter() -> void:
	# TODO: maybe change to RichText + statuses?
	$PanelContainer/Label.text = "%s %s %s\n%d/%d %d\n" % [npc_name, sex, race_name, body.get_current_health(), body.get_max_health(), body.total_blood]
	$PanelContainer/Label.text += "Alive: %s, consious: %s" % [body.is_alive, body.is_consious]
	$PanelContainer/Label.text += str(stats_handler.stats)
	$PanelContainer/Label.visible = true
	$PanelContainer.visible = true

func _mouse_exit() -> void:
	$PanelContainer/Label.visible = false
	$PanelContainer.visible = false
	
func _ready():
	print("_ready called, race_name is already set")
	var generated_npc: Array = NPCGenerator.generate_npc()
	var generated_race = generated_npc[0]
	var generated_sex = generated_npc[1]
	var generated_name = generated_npc[2]
	sex = generated_sex
	race_name = generated_race
	npc_name = generated_name
	race = $PropertyController/RaceController.get_race(race_name, npc_name)
	TimeProcesser.process_time.connect(_on_time_process)
	sprite_handler()
	fix_position()
	stats_handler.modify_stats(race.get_race_buffs())
	body.apply_buffs_and_reset(stats_handler.get_stat_int("CON"))
	$hbar.max_value = body.get_max_health()
	$bloodbar.max_value = body.total_blood
	$bloodbar.add_theme_color_override("font_outline_color", Color(1, 0, 0))
	print("%s %s %s, level %d, spare points %d" % [race.race_name, sex, npc_name, stats_handler.level, stats_handler.spare_points])
	print("Current race buffs: ", race.get_race_buffs())
	print("Current stats: ", stats_handler.get_stats_dict())
	print("%d/%d" % [body.get_max_health(), body.get_current_health()])
	update_hbar()
	print("\n")

func handle_death():
	print("%s has died, starting to rot" % npc_name)
	$hbar.queue_free()
	$bloodbar.queue_free()
	

func update_hbar():
	$hbar.value = body.get_current_health()
	$bloodbar.value = body.total_blood
	
func ping():
	if body.is_consious: return "Pong"
	else: return "silence"
	
func sprite_handler():
	# TODO: art-related
	# move to separate module
	# draw better sprites x(
	var sprite_name: String = race_name + sex
	$Sprite2D.texture = load("res://Sprites/NPC/%s/%s.png" % [race_name, sprite_name])
	if sex == "Male":
		pronouns["third_face"] = "he"
		pronouns["possesive"] = "his"
	if sex == "Female":
		pronouns["third_face"] = "she"
		pronouns["possesive"] = "her"
	if sex in ["BeastMale", "BeastFemale"]:
		pronouns["third_face"] = "it"
		pronouns["possesive"] = "it's"
#func _process(_delta) -> void:
	#if !stats_handler.is_alive: queue_free()

#func collision_handler(direction):
	#var raycast_x = tile_size * inputs[direction][0]
	#var raycast_y = tile_size * inputs[direction][1]
	#$RayCast2D.target_position = Vector2(raycast_x, raycast_y)
	#$RayCast2D.force_raycast_update()
	#return !$RayCast2D.is_colliding()

func _on_time_process(time_amount: int):
	print("%s processing time %d" % [npc_name, time_amount])
	if body.is_alive:
		update_hbar()
	else:
		if not state_corpse:
			state_corpse = true
			handle_death()
	if state_corpse: rot()

func rot():
	corpse_decaying_timer += 5
	print("%s rotting, %d / %d" % [npc_name, corpse_decaying_timer, corpse_decay_time])
	if corpse_decaying_timer >= corpse_decay_time:
		print("%s finished rotting, clearing" % npc_name)
		queue_free()
