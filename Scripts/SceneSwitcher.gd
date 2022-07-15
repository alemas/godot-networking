extends Node

var current_scene: Node = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func change_to_scene_with_instance(new_scene: Node, params = null):
	call_deferred("_deferred_change_to_scene_with_instance", new_scene, params)

func change_to_scene(path: String, params = null):
	call_deferred("_deferred_change_to_scene_with_path", path, params)

func _deferred_change_to_scene_with_path(path: String, params):
	var new_scene = ResourceLoader.load(path).instance()
	_deferred_change_to_scene_with_instance(new_scene, params)
	
func _deferred_change_to_scene_with_instance(new_scene: Node, params):
	current_scene.free()
	current_scene = new_scene
	if "params" in current_scene:
		new_scene.params = params
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
