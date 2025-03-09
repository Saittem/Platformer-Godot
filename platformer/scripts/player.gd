class_name Player
extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var attack_varient = "attack"

@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_area_left = $AnimatedSprite2D/hit_area_left/CollisionShape2D
@onready var hit_area_right = $AnimatedSprite2D/hit_area_right/CollisionShape2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle attack, run and idle animation
	if Input.is_action_just_pressed("attack"):
		if animated_sprite.flip_h:
			hit_area_right.disabled = false
		elif not animated_sprite.flip_h:
			hit_area_left.disabled = false
		
		if attack_varient == "attack":
			animated_sprite.play(attack_varient)
			attack_varient = "attack2"
		else:
			animated_sprite.play(attack_varient)
			attack_varient = "attack"

	elif (Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right")) and not animated_sprite.is_playing():
		animated_sprite.play("running")
	elif not (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and not animated_sprite.is_playing():
		animated_sprite.play("idle")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "attack" or "attack2":
		hit_area_right.disabled = true
		hit_area_left.disabled = true
		
	if animated_sprite.animation == "death":
		Global.death_count += 1
		get_tree().reload_current_scene()

# Handles enemy collition with hit_area
func _on_hit_area_body_entered(body):
	if body is Enemy:
		print("Hit: " + body.name)

func playerDied():
	print("You Died!")
	animated_sprite.play("death")
