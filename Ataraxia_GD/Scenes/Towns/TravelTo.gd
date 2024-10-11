extends Area2D
class_name Teleporter
@export var SceneTo: PackedScene

func changeScenes():
	print("Call %s" % changeScenes)
	var root = get_tree().root
	var scene_root = get_parent()
	# Works okay by now, fix player teleport position, try disconnecting scene
	root.add_child(SceneTo.instantiate())
	root.remove_child(scene_root)
