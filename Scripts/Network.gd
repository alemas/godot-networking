extends Node

const DEFAULT_PORT = 28960
const MAX_CLIENTS = 16

var peer = NetworkedMultiplayerENet.new()
var connections_count = 0

var ip_address = "127.0.0.1"
var players = {}

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

## Returns OK if the server was successfuly created
func create_server() -> int:
	var status = peer.create_server(DEFAULT_PORT, MAX_CLIENTS)
	if status == OK:
		get_tree().set_network_peer(peer)
	return status

## Returns OK if the connection was succesfully established
func join_server() -> int:
	var status = peer.create_client(ip_address, DEFAULT_PORT)
	if status == OK:
		 get_tree().set_network_peer(peer)
	return status


remote func register_player(player_info) -> void:
	var id = get_tree().get_rpc_sender_id()
	players[id] = player_info

# --------------------------------> SIGNALS

func _connected_to_server() -> void:
	print("Succesfully connected to the server")

func _failed_to_connect() -> void:
	print("Failed to connect to the server")
	get_tree().network_peer = null

func _server_disconnected() -> void:
	print("Disconnected from the server")
	ip_address = ""


func _network_peer_connected(id) -> void:
	print("Peer " + str(id) + " has connected")
	var player_info = {
		'player_id': id
	}
	# Register
	rpc_id(id, 'register_player', player_info)
	if is_server():
		connections_count += 1
	
func _network_peer_disconnected(id) -> void:
	print("Peer " + str(id) + " disconnected")
	players.erase(id)
	if is_server():
		connections_count -= 1
