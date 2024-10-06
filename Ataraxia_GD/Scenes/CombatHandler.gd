extends Control
# Called when the node enters the scene tree for the first time.
@export var enemy_object: Entity
@export var player_object: Player
func _ready() -> void:
	pass # Replace with function body.


func _on_enemy_part_got_hit(bodypart_name: String, damage_amount: int, bleed_severity: int) -> void:
	enemy_object.get_hit(bodypart_name, damage_amount, bleed_severity)
