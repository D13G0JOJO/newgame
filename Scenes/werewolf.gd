extends CharacterBody2D
@export var movement_speed = 50


@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $hitbox
@onready var player = $"../player"

var active = true
var gravity =  1600 
func _ready():
	hitbox.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if not active: 
		return
	
	velocity.x = -movement_speed
	velocity.y =  gravity  * delta
	move_and_slide() 

#left
 

func set_active(value):
	active = value
	if active: 
		sprite.play("walk")

func _on_body_entered(body):
	if body.is_in_group("player") and active:
		player.die()

func _on_player_died():
	set_active(false)
	sprite.play("idle")

func die():
	set_active(false)
	
