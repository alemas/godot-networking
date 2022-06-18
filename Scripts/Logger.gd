extends Node

signal logged_debug_message(message, style)
signal logged_chat_message(message)
signal logged_network_message(message, style)

enum MessageStyle {
	Text, Info, Warning, Error, Success
}

enum MessageType {
	Debug, Chat, Network
}

func _print_message(message, type, style = MessageStyle.Text):
	match type:
		MessageType.Debug:
			print_debug(message)
			emit_signal("logged_debug_message", message, style)
		MessageType.Chat:
			print(message)
			emit_signal("logged_chat_message", message)
		MessageType.Network:
			print(message)
			emit_signal("logged_network_message", message, style)
		
func log_debug(message, style = MessageStyle.Text):
	_print_message("[DEBUG] " + message, MessageType.Debug, style)
	
func log_chat(message, sender):
	_print_message("<" + sender + ">: " + message, MessageType.Chat, MessageStyle.Text)
	
func log_network(message, style = MessageStyle.Text):
	_print_message("[NET] " + message, MessageType.Network, style)
	
func color_for_style(style) -> Color:
	match style:
		MessageStyle.Text:
			return Color.gainsboro
		MessageStyle.Info:
			return Color.deepskyblue
		MessageStyle.Warning:
			return Color.gold
		MessageStyle.Error:
			return Color.crimson
		MessageStyle.Success:
			return Color.greenyellow
	return Color.white
