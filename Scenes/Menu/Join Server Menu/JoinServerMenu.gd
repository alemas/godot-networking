tool
extends Control

onready var background_rect = $Background
onready var player_name_line_edit = $MarginContainer/VBoxContainer/PlayerNameLineEdit
onready var server_ip_line_edit = $MarginContainer/VBoxContainer/ServerIPLineEdit
onready var connection_error_label = $MarginContainer/VBoxContainer/ConnectionErrorLabel

onready var join_button = $MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/JoinButton
onready var back_button = $MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/BackButton

var error_message = "Unable to connect to server. Status "

func _ready() -> void:
	background_rect.color = Colors.menu_background
	get_tree().connect("connected_to_server", self, "_on_joined_server")

func _join_server(ip_address: String):
	join_button.disabled = true
	back_button.disabled = true
	var status = Network.join_server(ip_address)
	join_button.disabled = false
	back_button.disabled = false
	if status != OK:
		connection_error_label.text = error_message + str(status)
		connection_error_label.show()

func _on_joined_server():
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Lobby Menu/LobbyMenu.tscn")

func _on_JoinButton_button_up() -> void:
	var player_name = player_name_line_edit.text.strip_edges(true, true)
	if player_name.length() > 0 and server_ip_line_edit.text.length() > 0:
		var ip_address = server_ip_line_edit.text
		_join_server(ip_address)
		Player.username = player_name

func _on_BackButton_button_up() -> void:
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Start Menu/StartMenu.tscn")

func _on_ServerIPLineEdit_text_changed(new_text: String) -> void:
	connection_error_label.hide()
