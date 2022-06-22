tool
extends Control

onready var background_rect = $Background
onready var player_name_line_edit = $MarginContainer/VBoxContainer/PlayerNameLineEdit
onready var server_ip_line_edit = $MarginContainer/VBoxContainer/ServerIPLineEdit

func _ready() -> void:
	background_rect.color = Colors.menu_background
	get_tree().connect("connected_to_server", self, "_on_joined_server")

func _on_JoinButton_button_up() -> void:
	var player_name = player_name_line_edit.text.strip_edges(true, true)
	if player_name.length() > 0 and server_ip_line_edit.text.length() > 0:
		var ip_address = server_ip_line_edit.text
		Network.join_server(ip_address)

func _on_BackButton_button_up() -> void:
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Start Menu/StartMenu.tscn")

func _on_joined_server():
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Lobby Menu/LobbyMenu.tscn")
