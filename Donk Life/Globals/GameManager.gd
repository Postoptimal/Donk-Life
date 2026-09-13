extends Node

var cfg: ConfigFile = ConfigFile.new()

# Game Settings
var vol_SFX: int
var vol_music: int

# Player Stats
var energy:      int
var skill_climb: int
var skill_run:   int
var skill_swim:  int
var racism:      int

# Scene Swapping
var target_scene: String
var scene: PackedScene = preload("res://Scenes/Transition/UIS_trans.tscn")

func loadscene(ScenePath: String) -> void:
	var loader = scene.instantiate()
	target_scene = ScenePath
	get_tree().root.add_child(loader)
	
func boot_config() -> void:
	if FileAccess.file_exists("user://player.cfg"):
		cfg.load("user://Config.cfg")
		vol_SFX = cfg.get_value("Audio","Volume_SFX",1)
		vol_music = cfg.get_value("Audio","Volume_Music",1)
		energy = cfg.get_value("Player","Energy",1)
		skill_climb = cfg.get_value("Player","Climb",1)
		skill_run = cfg.get_value("Player","Run",1)
		skill_swim = cfg.get_value("Player","Swim",1)
	else:
		cfg.set_value("Audio","Volume_SFX",50)
		cfg.set_value("Audio","Volume_Music",50)
		cfg.set_value("Player","Energy",10)
		cfg.set_value("Player","Climb",10)
		cfg.set_value("Player","Run",10)
		cfg.set_value("Player","Swim",10)
		cfg.set_value("Player","Racism",0)
		cfg.save("user://player.cfg")
		
	cfg.unreference()
