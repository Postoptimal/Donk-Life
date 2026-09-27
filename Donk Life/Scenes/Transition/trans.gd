extends CanvasLayer

func _ready() -> void:
	var tween_in: Tween = create_tween()
	tween_in.tween_property($Frame,"material:shader_parameter/progress",-0.5,0.4)
	await tween_in.finished
	var loader = ResourceLoader.load_threaded_request(GameManager.target_scene)

func _process(_delta: float) -> void:
	var load_stat = ResourceLoader.load_threaded_get_status(GameManager.target_scene)
	if load_stat == ResourceLoader.THREAD_LOAD_LOADED:
		var tween_out: Tween = create_tween()
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(GameManager.target_scene))
		tween_out.tween_property($Frame,"material:shader_parameter/progress",1.5,0.4)
		await tween_out.finished
		self.queue_free()
	else:
		pass
