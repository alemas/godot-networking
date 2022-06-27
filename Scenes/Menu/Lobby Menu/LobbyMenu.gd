extends Control

var params = {}

onready var pre_server_setup_ui = $PreServerSetupUI
onready var lobby_ui = $LobbyUI
onready var background_rect = $Background

var error_message = "Unable to start the server. Status "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_rect.color = Colors.menu_background
	if params != null and params.has("will_be_server"):
		if params.will_be_server == true:
			pre_server_setup_ui.show()
			return
			
	lobby_ui.show()


