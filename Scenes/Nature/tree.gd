extends StaticBody2D

var total_time = 15
var current_time: float
var units = 0

@onready var bar = $ProgressBar
@onready var timer = $Timer


func _ready():
	current_time = total_time
	bar.max_value = total_time

func _process(delta):
	bar.value = current_time
	if current_time <= 0:
		be_removed()

func _on_chop_area_body_entered(body):
	if "Unit" in body.name:
		units += 1
		be_chopped()


func _on_chop_area_body_exited(body):
	if "Unit" in body.name:
		units -= 1
		if units <= 0:
			timer.stop()


func _on_timer_timeout():
	current_time -= units
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", current_time, 0.5).set_trans(Tween.TRANS_LINEAR)
	
func be_chopped():
	timer.start()
	
func be_removed():
	Game.wood += 5
	queue_free()
	
