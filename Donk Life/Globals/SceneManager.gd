extends Node

var target_scene: String
var scene: PackedScene = preload("res://Scenes/Transition/UIS_trans.tscn")

func load(ScenePath: String) -> void:
	var loader = scene.instantiate()
	target_scene = ScenePath
	get_tree().root.add_child(loader)
