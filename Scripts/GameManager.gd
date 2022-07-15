extends Node

enum State {
	Lobby, ConfiguringGame, RunningGame
}
	
var state = State.Lobby

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pre_configure_game():
	state = State.ConfiguringGame
	var self_id = Network.get_net_id()
	
	# Load Map
	var debug_map = load("res://Scenes/World/Maps/Debug Map/DebugMap.tscn").instance()
	
	# Load Player
	var player = load("res://Scenes/World/Entities/Player Entity/PlayerEntity.tscn").instance()
	debug_map.add_child(player)
	debug_map.spawn_player(player)
	
	SceneSwitcher.change_to_scene_with_instance(debug_map)
	

remote func start_game():
	pre_configure_game()

