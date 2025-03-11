class_name Enemy
extends CharacterBody2D

@onready var target = $"../Player"
@export var speed: float = 150.0
@onready var animated_sprite = $"AnimatedSprite2D"

func _physics_process(delta):
	var direction = (target.position - position).normalized()
	
	# Apply horizontal movement
	velocity.x = direction.x * speed

	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += get_gravity().y * delta  

	# Flip sprite based on movement direction
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

	move_and_slide()

	print("Direction: ", direction)
