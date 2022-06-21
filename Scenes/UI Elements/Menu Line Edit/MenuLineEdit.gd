tool
extends LineEdit

onready var base_style = preload("res://Resources/StyleBoxes/MenuLineEditStyleBox.tres")

func _ready() -> void:
	base_style.bg_color = Colors.menu_line_edit_background
	self.add_stylebox_override("normal", base_style)
	self.add_stylebox_override("focus", base_style)
