extends Resource
class_name BasicItem

@export var item_name: String = "placeholder_item_name"
@export var item_desc: String = "placeholder_item_desc"
@export var item_texture: Texture2D = null
@export var item_weight: int = 1
@export_enum("CONSUMABLE", "WEAPON", "ARMOR", "MATERIAL") var item_class: String
@export var quest_restricted: bool = false

func DEBUG() -> void:
	print("%s\n%s %s %d %s %s" %
	[DEBUG, item_name, item_desc,item_weight, item_class, quest_restricted])
func is_quest_item() -> bool: return quest_restricted
func get_item_class() -> String: return item_class
func get_item_weight() -> int: return item_weight
