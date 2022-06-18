extends RichTextLabel

export var show_network = true
export var show_chat = true
export var show_debug = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.connect("logged_debug_message", self, "_print_debug")
	Logger.connect("logged_chat_message", self, "_print_chat")
	Logger.connect("logged_network_message", self, "_print_network")
		
func _print(text, style = Logger.MessageType.Text):
	self.push_color(Logger.color_for_style(style))	
	self.add_text("\n" + text)
	
func _print_debug(message, style):
	if show_debug:
		_print(message, style)
	
func _print_chat(message):
	if show_chat:
		_print(message)
	
func _print_network(message, style):
	if show_network:
		_print(message, style)
