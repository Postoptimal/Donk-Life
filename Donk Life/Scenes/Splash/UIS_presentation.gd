extends CanvasLayer

@onready var story_text = $VBoxContainer/ColorRect/Story
@onready var story_image = $VBoxContainer/ColorRect/Image

var storyslides: Array[CompressedTexture2D] = [
	preload("res://Assets/Story Slides/storyslide_ph01.png"),
	preload("res://Assets/Story Slides/storyslide_ph02.png"),
	preload("res://Assets/Story Slides/storyslide_ph03.png"),
	preload("res://Assets/Story Slides/storyslide_ph04.png")
]

var storylines: Array[String] = [
	"One day, a brave donkey named Lil Donk joined the big race",
	"He was untrained and got quickly left behind",
	"Sadly, Lil Donk also broke his leg",
	"He now swears to train, even with a healing leg, to compete again!"
]

var slide_count: int = 0

func _ready() -> void:
	update_slide()

func update_slide() -> void:
	story_text.text = storylines[slide_count]
	story_image.texture = storyslides[slide_count]
	
	$VBoxContainer/HBoxContainer/Left.text = "PREV"
	if slide_count == 0: $VBoxContainer/HBoxContainer/Left.text = "SKIP"
	
	$VBoxContainer/HBoxContainer/Right.text = "NEXT"
	if slide_count == 3: $VBoxContainer/HBoxContainer/Right.text = "PLAY"

func _on_left_pressed() -> void:
	if slide_count == 0: GameManager.loadscene("uid://jo11i74k7bv")
	else: slide_count -= 1
	update_slide()

func _on_right_pressed() -> void:
	if slide_count == 3: GameManager.loadscene("uid://jo11i74k7bv")
	else: slide_count += 1
	update_slide()

func _on_left_mouse_entered()  -> void:$VBoxContainer/HBoxContainer/Left.offset_transform_rotation = -0.07
func _on_left_mouse_exited()   -> void: $VBoxContainer/HBoxContainer/Left.offset_transform_rotation = 0.00
func _on_right_mouse_entered() -> void: $VBoxContainer/HBoxContainer/Right.offset_transform_rotation = -0.07
func _on_right_mouse_exited()  -> void: $VBoxContainer/HBoxContainer/Right.offset_transform_rotation = 0.00
