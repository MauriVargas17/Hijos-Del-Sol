extends CharacterBody2D


@export var is_selected = false
@onready var box = get_node("Box")
@onready var animation = get_node("AnimationPlayer")

@onready var target = position
var follow_cursor = false
var speed = 150
@onready var unit_proximity = $Box.size.x / 5

func _ready():
	set_selected(is_selected)
	
func set_selected(_is_selected):
	is_selected = _is_selected
	box.visible = _is_selected
	
func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false 
		
func _physics_process(delta):
	if follow_cursor == true:
		if is_selected:
			target = get_global_mouse_position()
			animation.play("Walk_Down")
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target) > unit_proximity:
		move_and_slide()
	else:
		animation.stop()
		pass

