tool
extends Button

onready var base_style = preload("res://Resources/StyleBoxes/MenuButtonStyleBox.tres")

func _ready():

	self.add_color_override("font_color", Colors.menu_button_font)

	var normal_style = base_style.duplicate()
	normal_style.bg_color = Colors.menu_button_background
	normal_style.border_color = Colors.menu_button_border
	self.add_stylebox_override("normal", normal_style)
	self.add_color_override("font_color", Colors.menu_button_font)
	
	var highlighted_style = normal_style.duplicate()
	highlighted_style.bg_color = Colors.menu_button_background_highlighted
	self.add_stylebox_override("pressed", highlighted_style)
	self.add_color_override("font_color_pressed", Colors.menu_button_font_highlighted)
	
	self.add_stylebox_override("hover", normal_style)
	self.add_color_override("font_color_hover", Colors.menu_button_font_highlighted)
	
#	self.add_stylebox_override("focus", normal_style)
	self.add_color_override("font_color_focus", Colors.menu_button_font_highlighted)
