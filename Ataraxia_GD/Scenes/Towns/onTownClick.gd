extends Button

@export_enum("Town1", "Town2") var scene_name_to: String
@export_enum("Town1", "Town2") var scene_name_from: String

func _ready() -> void: pass

func _pressed() -> void:
	SceneSwitcher.switch_scene_to(scene_name_to, scene_name_from)
