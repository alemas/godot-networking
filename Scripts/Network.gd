extends Node

const DEFAULT_PORT = 28960
const MAX_CLIENTS = 16

var peer = NetworkedMultiplayerENet.new()
var connections_count = 0

var ip_address = "127.0.0.1"
var players = {}

# Custom signals

signal added_new_player(new_player)

func _ready() -> void:
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168.") and not ip.ends_with(".1"):
			ip_address = ip
	
	# Executes on the client side
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("connection_failed", self, "_failed_to_connect")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
	# Executes on the client and server side
	get_tree().connect("network_peer_connected", self, "_network_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_network_peer_disconnected")
	
func is_server() -> bool:
	return get_tree().is_network_server()

func get_local_addresses_description() -> String:
	var description = "Available addresses: "
	for i in IP.get_local_interfaces():
		var interfaceDescription = "\n" + i["name"] + ": "
		if i["friendly"] != "":
			interfaceDescription = "\n" + i["friendly"] + ": "
		for ip in i["addresses"]:
			interfaceDescription += "\n\t" + ip
		description += interfaceDescription
	return description

## Returns OK if the server was successfuly created
func create_server() -> int:
	var status = peer.create_server(DEFAULT_PORT, MAX_CLIENTS)
	if status == OK:
		get_tree().set_network_peer(peer)
		Logger.log_network("Started local server", Logger.MessageStyle.Success)
	else:
		Logger.log_network("Failed to create local server. Status" + str(status), Logger.MessageStyle.Error)
	return status

## Returns OK if the connection was succesfully established
func join_server() -> int:
	var status = peer.create_client(ip_address, DEFAULT_PORT)
	if status == OK:
		get_tree().set_network_peer(peer)
		Logger.log_network("Joining Server", Logger.MessageStyle.Success)
	else:
		Logger.log_network("Failed to connect to server " + ip_address + ". Status" + str(status), Logger.MessageStyle.Error)
	return status

func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().set_network_peer(null)

remote func register_player(player_info) -> void:
	var id = get_tree().get_rpc_sender_id()
	players[id] = player_info
	emit_signal("added_new_player", player_info)

# --------------------------------> SIGNALS

	# CLIENT SIDE

func _connected_to_server() -> void:
	Logger.log_network("Succesfully connected to the server", Logger.MessageStyle.Success)

func _failed_to_connect() -> void:
	Logger.log_network("Failed to connect to the server", Logger.MessageStyle.Error)
	reset_network_connection()

func _server_disconnected() -> void:
	Logger.log_network("Disconnected from the server", Logger.MessageStyle.Warning)
	ip_address = ""
	reset_network_connection()

	# CLIENT & SERVER SIDE

func _network_peer_connected(id) -> void:
	Logger.log_network("Peer " + str(id) + " has connected", Logger.MessageStyle.Success)
	var player_info = {
		'name': id
	}
	# Register player to players
	rpc_id(id, 'register_player', player_info)
	if is_server():
		connections_count += 1
	
func _network_peer_disconnected(id) -> void:
	Logger.log_network("Peer " + str(id) + " disconnected", Logger.MessageStyle.Warning)
	players.erase(id)
	if is_server():
		connections_count -= 1
