extends Control

onready var multiplayer_config_ui = $Multiplayer_configure
onready var server_ip_address = $Multiplayer_configure/Server_ip_address
onready var join_button = $Multiplayer_configure/Join_server
onready var host_button = $Multiplayer_configure/Create_server

onready var device_ip_address = $CanvasLayer/Device_ip_address
onready var console_log = $CanvasLayer/Console_log
onready var logger = $CanvasLayer/Logger

func _ready() -> void:
	device_ip_address.text = Network.ip_address
	
	Logger.log_network(Network.get_local_addresses_description(), Logger.MessageStyle.Info)

func _on_Host_server_button_up():
	var status = Network.create_server()
	if status == OK:
		multiplayer_config_ui.hide()

func _on_Join_server_button_up():
	if server_ip_address.text != "":
		var status = Network.join_server(server_ip_address.text)
		if status == OK:
			multiplayer_config_ui.hide()
