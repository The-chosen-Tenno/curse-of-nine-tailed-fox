extends CharacterBody2D

const WALK_SPEED = 200.0
const SPRINT_SPEED = 350.0
const JUMP_VELOCITY = -400.0
var dead = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if dead:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Check if holding sprint 
	var current_speed = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		current_speed = SPRINT_SPEED
		
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true

	# Move 
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	# Animations
	if not is_on_floor():
		animated_sprite_2d.play("jump")
	elif direction != 0:
		if Input.is_action_pressed("sprint"):
			animated_sprite_2d.play("sprint")
		else:
			animated_sprite_2d.play("walking")
	else:
		animated_sprite_2d.play("idle1")

	move_and_slide()
