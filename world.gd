extends Node2D

var units = []

func _ready():
	units = get_tree().get_nodes_in_group("units")

func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	for unit in units:
		unit.set_selected(false)
	for unit in units_in_area:
		unit.set_selected(!unit.is_selected)
	
func get_units_in_area(area):
	var units_highlighted = []
	for unit in units:
		if _is_inside_the_box(unit, area):
			units_highlighted.append(unit)
	return units_highlighted
	
func _is_inside_the_box(unit, area) -> bool:
	return (unit.position.x > area[0].x) and (unit.position.x < area[1].x) and (unit.position.y > area[0].y) and (unit.position.y < area[1].y)
