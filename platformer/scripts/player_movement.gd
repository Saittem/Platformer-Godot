extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var attack_variant = 0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle attacks
	if Input.is_action_just_pressed("attack"):
		if attack_variant == 0:
			animated_sprite.play("attack")
			attack_variant += 1
		else:
			animated_sprite.play("attack2")
			attack_variant = 0
			


	var direction := Input.get_axis("left", "right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("running")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
