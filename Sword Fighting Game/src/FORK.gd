extends CharacterBody2D


var attached = false

func _physics_process(delta: float) -> void:
	if colliding():
		attached = true
		velocity = Vector2(0, 0)
	move_and_slide()
	
func colliding() -> bool:
	return is_on_ceiling() or is_on_wall() or is_on_floor()
	
func is_attached() -> bool:
	return attached
