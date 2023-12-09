extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -400.0
const DAMPER = 0
const AIR_DAMPER = 0.99
@onready var sprite_2d = $Sprite

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = 0 # ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and colliding()	:
		velocity.x += (get_global_mouse_position().x - position.x)/2
		velocity.y += (get_global_mouse_position().y - position.y)/2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x += direction * SPEED
		sprite_2d.flip_h = direction == -1
	velocity.x = velocity.x * DAMPER if colliding() else velocity.x * AIR_DAMPER
	velocity.y = velocity.y * DAMPER if colliding() else velocity.y * AIR_DAMPER
	

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed( 1 ):
		velocity.x += (get_global_mouse_position().x - position.x)/2
		velocity.y += (get_global_mouse_position().y - position.y)/2
		
func colliding() -> bool:
	return is_on_ceiling() or is_on_wall() or is_on_floor()
