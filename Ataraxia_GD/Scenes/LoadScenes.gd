extends Button

func _pressed() -> void:
	#TimeProcesser.start_time = 0x3840
	SceneSwitcher.set_starting_scene("Town1")
	SceneSwitcher.prepare()
	SceneSwitcher.start_game()
	# print_orphan_nodes() - orphan nodes = unloaded scenes, do not care
	get_parent().visible = false
