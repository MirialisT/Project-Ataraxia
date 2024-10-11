extends Button

@export var SceneToLoad: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _pressed() -> void:
	var root = get_tree().root
	root.add_child(SceneToLoad.instantiate())
	get_parent().visible = false
