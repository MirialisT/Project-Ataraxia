extends Node

var inactive_scenes: Dictionary
var current_scene: Node
var starting_scene: Node
var viable_scenes: Array[String] = ["Town2"]
func _ready() -> void:
	starting_scene = preload("res://Scenes/Towns/Town1.tscn").instantiate()
	starting_scene.spawn_player()
	
func start() -> void:
	var root = get_tree().root
	for scene_name in viable_scenes:
		var scene_to_load: PackedScene = load("res://Scenes/Towns/%s.tscn" % scene_name)
		root.add_child(scene_to_load.instantiate())
		inactive_scenes[scene_name] = root.get_child(-1)
		root.remove_child(root.get_child(-1))
	starting_scene.inactive = false
	root.add_child(starting_scene)
	current_scene = root.get_child(-1)

# split for town switch and in-town switch without global time processing
func switch_scene_to(scene_name_to: String, scene_name_from: String):
	var root = get_tree().root
	var player_container: Node = null
	player_container = current_scene.unload_player()
	root.remove_child(current_scene)
	current_scene.inactive = true
	inactive_scenes[scene_name_from] = current_scene
	inactive_scenes[scene_name_to].spawn_player(player_container)
	inactive_scenes[scene_name_to].inactive = false
	root.add_child(inactive_scenes[scene_name_to])
	inactive_scenes.erase(scene_name_to)
	current_scene = root.get_child(-1)
	print("Switched from %s to %s, triggering time processing" % [scene_name_from, scene_name_to])
	current_scene.process_global_time()
