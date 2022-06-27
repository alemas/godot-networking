extends MarginContainer

onready var background_rect = $Background
onready var logger_text_label = $MarginContainer/LoggerTextLabel

export var show_network = true
export var show_chat = true
export var show_debug = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.connect("logged_debug_message", self, "_print_debug")
	Logger.connect("logged_chat_message", self, "_print_chat")
	Logger.connect("logged_network_message", self, "_print_network")
		
func _print(text, style = Logger.MessageType.Text):
	logger_text_label.push_color(Logger.color_for_style(style))
	if not logger_text_label.text.empty():
		logger_text_label.add_text("\n")
	logger_text_label.add_text(text)
	
func _print_debug(message, style):
	if show_debug:
		_print(message, style)
	
func _print_chat(message):
	if show_chat:
		_print(message)
	
func _print_network(message, style):
	if show_network:
		_print(message, style)
