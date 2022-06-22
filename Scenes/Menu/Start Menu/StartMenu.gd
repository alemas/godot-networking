tool
extends Control

onready var lblGameTitle = $MarginContainer/VBoxContainer/GameTitle
onready var rctBackground = $Background

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rctBackground.color = Colors.menu_background

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_JoinButton_button_up() -> void:
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Join Server Menu/JoinServerMenu.tscn")

func _on_HostButton_button_up() -> void:
	SceneSwitcher.change_to_scene("res://Scenes/Menu/Lobby Menu/LobbyMenu.tscn", {"will_be_server": true})

func _on_QuitButton_button_up() -> void:
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
