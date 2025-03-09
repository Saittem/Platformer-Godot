class_name Enemy
extends CharacterBody2D

# Handles gravity
func _physics_process(delta):
	if not is_on_floor():
		velocity = get_gravity() * delta
