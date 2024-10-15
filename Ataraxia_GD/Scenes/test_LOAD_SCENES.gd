extends Button

@export var scenes_to_load: Array[PackedScene]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _pressed() -> void:
	SceneSwitcher.start()
	get_parent().visible = false
