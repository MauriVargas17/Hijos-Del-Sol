extends CharacterBody2D


@export var is_selected = false
@onready var box = get_node('Box')

func _ready():
	set_selected(is_selected)
	
func set_selected(_is_selected):
	box.visible = _is_selected


func _on_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
