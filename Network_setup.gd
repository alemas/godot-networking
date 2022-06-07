extends Control

onready var multiplayer_config_ui = $Multiplayer_configure
onready var server_ip_address = $Multiplayer_configure/Server_ip_address

onready var device_ip_address = $CanvasLayer/Device_ip_address
onready var console_log = $CanvasLayer/Console_log

const info_color = Color.deepskyblue
const text_color = Color.gainsboro
const warning_color = Color.gold
const error_color = Color.crimson
const success_color = Color.greenyellow

func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	
	device_ip_address.text = Network.ip_address
	
	_print_to_console("Available Local Addresses:", ConsoleMessageType.Info)
	
	for i in IP.get_local_interfaces():
		var interfaceDescription = i["name"] + ": "
		for ip in i["addresses"]:
			interfaceDescription += "\n\t" + ip
		_print_to_console(interfaceDescription)
	
func _player_connected(id) -> void:
	_print_to_console("Player " + str(id) + " has connected", ConsoleMessageType.Success)
	
func _player_disconnected(id) -> void:
	_print_to_console("Player " + str(id) + " has disconnected", ConsoleMessageType.Warning)

func _on_Create_server_button_up():
	var status = Network.create_server()
	if status == OK:
		multiplayer_config_ui.hide()
		_print_to_console("Server has started", ConsoleMessageType.Success)
	else:
		_print_to_console("Error starting server", ConsoleMessageType.Error)

func _on_Join_server_button_up():
	if server_ip_address.text != "":
		Network.ip_address = server_ip_address.text
		var status = Network.join_server()
		if status == OK:
			multiplayer_config_ui.hide()
			_print_to_console("Joined server", ConsoleMessageType.Success)
		else:
			_print_to_console("Couldn't connect to the server", ConsoleMessageType.Error)
	
enum ConsoleMessageType {
	Text, Info, Warning, Error, Success
}

func _print_to_console(text, style = ConsoleMessageType.Text):
	match style:
		ConsoleMessageType.Text:
			console_log.push_color(text_color)
		ConsoleMessageType.Info:
			console_log.push_color(info_color)
		ConsoleMessageType.Warning:
			console_log.push_color(warning_color)
		ConsoleMessageType.Error:
			console_log.push_color(error_color)
		ConsoleMessageType.Success:
			console_log.push_color(success_color)
	
	console_log.add_text("\n" + text)
