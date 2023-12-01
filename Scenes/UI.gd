extends CanvasLayer


@onready var label = $Label

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "Wood: " + str(Game.wood) 
