extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -400.0
const DAMPER = 0.8
const AIR_DAMPER = 0.85

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED
	velocity.x = velocity.x * DAMPER if is_on_floor() else velocity.x * AIR_DAMPER

	move_and_slide()
