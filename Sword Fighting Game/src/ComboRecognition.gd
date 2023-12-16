extends Node2D

var points = Array()
var size = 0
var corners = Array()
var length = 101.0
func find_corners(coordinates) -> Array:
	# actual shape recognition here #
	var output = Array()
	return output
	
# Called every frame. 'delta' is the elapsed time since the previous frame. #
func _physics_process(delta: float) -> void:
	await get_tree().create_timer(0.05).timeout
	size = int(points.size())
	# records coordinates, checks them for shapes, then deletes them #
	if Input.is_action_pressed("LEFT_MOUSE"):
		var mouse = get_local_mouse_position()
		# makes sure the distance between new point and old point is not too small (reduces lag) #
		if size > 1:
			length = sqrt(((points[size-1].x-mouse.x)**2.0)+((points[size-1].y-mouse.y)**2.0))
			if length > 10:
				# adds points to list, then finds best corners of shape #
				points.append(mouse)
				corners = find_corners(points)
		else:
			points.clear()
			points.append(mouse)
			points.append(mouse)
	elif Input.is_action_just_released("LEFT_MOUSE"):
		points.clear()
	queue_redraw()
func _draw() -> void:
	# draws lines from coordinates #
	if size > 1:
		draw_polyline(points, Color("#f030a3"), 3)
	if corners.size() > 1:
		draw_polyline(corners, Color("#f030a3"), 3)
