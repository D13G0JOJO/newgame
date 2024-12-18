extends CharacterBody2D


@export var SPEED = 300.0
@export var gravity = 9.8
@export var JUMP_VELOCITY = -500.0
@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

var active = true

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if active:
		if !is_on_floor():
			velocity.y += gravity 
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			sprite.play("jump")

		# jump reset
		#direction
		if Input.is_action_just_pressed("left"):
			sprite.flip_h = true
		elif Input.is_action_just_pressed("right"):
			sprite.flip_h = false
	
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
			sprite.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()

func die(): 
	sprite.play("die")
	active = false
	collision_shape.set_deferred("disabled",true)


func _on_animation_finished() -> void:
	sprite.play("idle")
