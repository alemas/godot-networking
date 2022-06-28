extends MarginContainer

onready var logger = $HBoxContainer/LoggerBackground/Logger
onready var players_text_label = $HBoxContainer/VBoxContainer/PlayersTextLabel
onready var back_button = $HBoxContainer/VBoxContainer/HBoxContainer/BackButton
onready var start_game_button = $HBoxContainer/VBoxContainer/HBoxContainer/StartGameButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Logger.log_network(Network.get_local_addresses_description())
	Network.connect("added_new_player", self, "_update_players_text_label")
	Network.connect("removed_player", self, "_update_players_text_label")
	_update_players_text_label()

func _update_players_text_label(player_info = null):
	var text = "Connected Players:"
	
	for player in Network.get_players().values():
		text += "\n" + str(player.username)
		
	players_text_label.text = text

func _on_LobbyUI_visibility_changed() -> void:
	if self.is_visible_in_tree():
		_update_players_text_label()
		if not Network.is_server():
			start_game_button.hide()
			
func _on_BackButton_button_up() -> void:
	if Network.is_server():
		Network.stop_server()
	else:
		Network.disconnect_from_server()
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Start Menu/StartMenu.tscn")
