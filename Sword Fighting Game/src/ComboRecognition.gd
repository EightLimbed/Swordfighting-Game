extends Node2D


var points = Array()
var size = 0
var corners = Array()
var length = 101.0

# Called every frame. 'delta' is the elapsed time since the previous frame. #
func _physics_process(delta: float) -> void:
	await get_tree().create_timer(0.05).timeout
	size = int(points.size())
	# records coordinates, checks them for shapes, then deletes them #
	if Input.is_action_pressed("LEFT_MOUSE"):
		var mouse = get_local_mouse_position()
		# makes sure the distance between new point and old point is not too small (reduces lag) #
		if size > 1:
			length = points[size - 1].distance_to(mouse)
			if length > 10:
				# adds points to list, then finds best corners of shape #
				points.append(mouse)
		else:
			points.clear()
			points.append(mouse)
			points.append(mouse)
	elif Input.is_action_just_released("LEFT_MOUSE"):
		points.clear()
	queue_redraw()
func _draw() -> void:
	# draws lines from coordinates #
	if size > 2:
		draw_polyline(points, Color("#f030a3"), 3)
		draw_polyline(corners, Color("#f030a3"), 3)
