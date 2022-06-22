extends Control

var params = {}
onready var pre_server_setup_ui = $PreServerSetupUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if params != null and params.has("will_be_server"):
		if params.will_be_server == true:
			pre_server_setup_ui.show()

func _on_BackButton_button_up() -> void:
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Start Menu/StartMenu.tscn")
