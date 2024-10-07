extends TextureButton

@export var bodypart_name: String

signal enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# TODO: battle-system related
# Switch to bodypart selection with hit confirmation. Maybe do before weapons, make separate buttons for debug
func _pressed() -> void:
	print("Call %s | damage comes from here now" % _pressed)
	# range for bleeding, damage amount on UI
	# print("Hitting part %s by %d with %d bleed severity" % [bodypart_name, 5, 0])
	enemy_part_got_hit.emit(bodypart_name, 5, 0)
