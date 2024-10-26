extends Button

func _pressed() -> void:
	SceneSwitcher.start()
	get_parent().visible = false
