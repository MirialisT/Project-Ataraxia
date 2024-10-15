extends Button

@export var scenes_to_load: Array[PackedScene]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _pressed() -> void:
	var root = get_tree().root
	for scene in scenes_to_load:
		var ready_scene: Node = scene.instantiate()
		ready_scene.inactive = true
		ready_scene.visible = false
		root.add_child(ready_scene)
	var starting_scene: Node = root.get_child(-1)
	starting_scene.spawn_player()
	starting_scene.visible = true
	get_parent().visible = false
