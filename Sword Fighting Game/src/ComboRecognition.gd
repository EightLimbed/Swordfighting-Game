extends Node2D

var Points = Array()
var Size = 0
var Corners = Array()
var Length = 101.0
func find_corners(Coordinates) -> Array:
	# actual shape recognition here #
	var Output = Array()
	return Output
	
# Called every frame. 'delta' is the elapsed time since the previous frame. #
func _physics_process(delta: float) -> void:
	await get_tree().create_timer(0.05).timeout
	Size = int(Points.size())
	# records coordinates, checks them for shapes, then deletes them #
	if Input.is_action_pressed("LEFT_MOUSE"):
		# makes sure the distance between new point and old point is not too small (reduces lag) #
		if Size > 1:
			Length = sqrt(((Points[Size-1].x-get_local_mouse_position().x)**2.0)+((Points[Size-1].y-get_local_mouse_position().y)**2.0))
			if Length > 10:
				# adds points to list, then finds best corners of shape #
				Points.append(get_local_mouse_position())
				Corners = find_corners(Points)
		else:
			Points.clear()
			Points.append(get_local_mouse_position())
			Points.append(get_local_mouse_position())
	elif Input.is_action_just_released("LEFT_MOUSE"):
		Points.clear()
	queue_redraw()
func _draw() -> void:
	# draws lines from coordinates #
	if Size > 1:
		draw_polyline(Points, Color("#f030a3"), 3)
		draw_polyline(Corners, Color("#f030a3"), 3)
