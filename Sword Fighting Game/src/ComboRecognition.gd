extends Node2D

var Points = Array()
var Length = Points.size()

# Called every frame. 'delta' is the elapsed time since the previous frame. #
func _physics_process(delta: float) -> void:
	Length = Points.size()
	queue_redraw()
	
	# Records coordinates, checks them for shapes, then deletes them #
	if Input.is_action_pressed("LEFT_MOUSE"):
		Points.append(get_local_mouse_position())
	else:
		# put shape recognition here #
		Points.clear()

func _draw() -> void:
	
	# Draws Line #
	if Length > 1:
		draw_polyline(Points, Color("#f030a3"), 3)
