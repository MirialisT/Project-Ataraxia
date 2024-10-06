extends TextureButton

@export var bodypart_name: String

signal enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _pressed() -> void:
	# range for bleeding, damage amount on UI
	print("Hitting part %s by %d with %d bleed severity" % [bodypart_name, 5, 0])
	enemy_part_got_hit.emit(bodypart_name, 5, 0)
	pass

func _on_mouse_entered():
	print("HEAD")
