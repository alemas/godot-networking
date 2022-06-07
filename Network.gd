extends Node

const DEFAULT_PORT = 28960
const MAX_CLIENTS = 6

var server = null
var client = null

var ip_address = "127.0.0.1"

func _ready() -> void:
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168.") and not ip.ends_with(".1"):
			ip_address = ip
			
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
func create_server() -> int:
	server = NetworkedMultiplayerENet.new()
	var status = server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	if status == OK:
		get_tree().set_network_peer(server)
	return status

## Returns OK if the connection was succesfully established
func join_server() -> int:
	client = NetworkedMultiplayerENet.new()
	var status = client.create_client(ip_address, DEFAULT_PORT)
	if status == OK:
		 get_tree().set_network_peer(client)
	return status
	
func _connected_to_server() -> void:
	print("Succesfully connected to server")

func _server_disconnected() -> void:
	print("Disconnected from server")
