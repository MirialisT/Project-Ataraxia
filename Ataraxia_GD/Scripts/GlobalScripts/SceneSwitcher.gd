extends Node

var inactive_scenes: Array[PackedScene]
var current_scene: Node
var starting_scene: PackedScene

func _ready() -> void:
	starting_scene = load("res://Scenes/Towns/Town1.tscn")
