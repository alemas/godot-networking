extends MarginContainer

onready var player_name_line_edit = $VBoxContainer/PlayerNameLineEdit
onready var connection_error_label = $VBoxContainer/ConnectionErrorLabel

onready var start_button = $VBoxContainer/CenterContainer/VBoxContainer/StartButton
onready var back_button = $VBoxContainer/CenterContainer/VBoxContainer/BackButton

var error_message = "Unable to start the server. Status "

func _start_server():
	start_button.disabled = true
	back_button.disabled = true
	var status = Network.create_server()
	if status != OK:
		connection_error_label.text = error_message + str(status)
		connection_error_label.show()
		start_button.disabled = false
		back_button.disabled = false
	else:
		self.hide()
		$"../LobbyUI".show()

func _on_BackButton_button_up() -> void:
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Start Menu/StartMenu.tscn")

func _on_StartButton_button_up() -> void:
	connection_error_label.hide()
	var player_name = player_name_line_edit.text.strip_edges(true, true)
	if player_name.length() > 0:
		Player.username = player_name
		_start_server()
