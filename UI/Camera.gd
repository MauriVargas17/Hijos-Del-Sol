extends Camera2D

@onready var panel_node = get_node("../UI/Panel")

var mouse_pos = Vector2()
var mouse_pos_global = Vector2()

var start = Vector2()
var start_v = Vector2()
var end = Vector2()
var end_v = Vector2()

var is_dragging = false
signal area_selected
signal start_move_selection

const DISTANCE_THRESHOLD = 20

func _ready():
	connect("area_selected", Callable(get_parent(), "_on_area_selected"))

func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		start = mouse_pos_global
		start_v = mouse_pos
		is_dragging = true
	if is_dragging:
		end = mouse_pos_global
		end_v = mouse_pos
		draw_area()
	if Input.is_action_just_released("LeftClick"):
		if start_v.distance_to(mouse_pos) > DISTANCE_THRESHOLD:
			end = mouse_pos_global
			end_v = mouse_pos
			is_dragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start
			is_dragging = false
			draw_area(false)
			
func _input(event):
	if event is InputEventMouse:
		mouse_pos = event.position
		mouse_pos_global = get_global_mouse_position()

func draw_area(is_selected = true):
	panel_node.size = Vector2(abs(start_v.x - end_v.x), abs(start_v.y - end_v.y))
	var pos = Vector2()
	pos.x = min(start_v.x, end_v.x)
	pos.y = min(start_v.y, end_v.y)
	panel_node.position = pos
	panel_node.size *= int(is_selected)
	
	
