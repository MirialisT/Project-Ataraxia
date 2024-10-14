extends Button

@export var SceneToLoad: PackedScene

func _ready() -> void: pass

func _pressed() -> void:
	var root = get_tree().root
	root.add_child(SceneToLoad.instantiate())
	get_parent().visible = false
