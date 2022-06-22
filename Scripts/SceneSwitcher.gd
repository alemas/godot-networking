extends Node

var current_scene: Node = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func change_to_scene(path: String, params = null):
	call_deferred("_deferred_change_to_scene", path, params)

func _deferred_change_to_scene(path: String, params):
	current_scene.free()
	var new_scene = ResourceLoader.load(path)
	current_scene = new_scene.instance()
	if "params" in current_scene:
		current_scene.params = params
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
