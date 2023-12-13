extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = 300.0
const DAMPER = 0
const AIR_DAMPER = 0.99
const GRAPPLE_SPEED = 1000
const GRAPPLE_STRENGTH = 30
const GRAPPLE_DIST_MIN = 50
const FORK = preload("res://actors/FORK/FORK.tscn")
var fork
const FORK_OFFSET = 36
@onready var sprite_2d = $Sprite

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = 0 # ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	move_and_slide()
	do_gravity(delta)
	do_fork()
	walk()
	damper()
	jump()

func do_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func do_fork() -> void:
	if Input.is_action_just_pressed("LEFT_MOUSE"):
		if fork == null:
			fork = FORK.instantiate()
			var to_mouse = Vector2(get_global_mouse_position().x - position.x, get_global_mouse_position().y - position.y).normalized()
			fork.position = position + (to_mouse * FORK_OFFSET)
			fork.look_at(get_global_mouse_position())
			get_node(".").get_parent().add_child(fork)
			fork.velocity = to_mouse * GRAPPLE_SPEED	
	if not fork == null and fork.is_attached():
		var diff = Vector2(fork.position.x - position.x, fork.position.y - position.y)
		velocity += diff.normalized() * GRAPPLE_STRENGTH
		if fork.position.distance_to(position) < GRAPPLE_DIST_MIN:
			fork.queue_free()

func walk() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED
		sprite_2d.flip_h = direction == -1

func damper() -> void:
	if fork == null or not fork.is_attached:
		velocity = velocity * DAMPER if colliding() else velocity * AIR_DAMPER

func jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and colliding():
		var diff = Vector2(get_global_mouse_position().x - position.x, get_global_mouse_position().y - position.y)
		velocity = diff.normalized() * JUMP_VELOCITY

func colliding() -> bool:
	return is_on_ceiling() or is_on_wall() or is_on_floor()
