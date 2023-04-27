extends CharacterBody2D


# always running right
# junmp
# crouch + gravity

# kill function
# slowing after hit
# timer for speed gain
# invulnerability

# animations

# extras
# coyote + jump buffer + variable jump hiegth
# particls
# raycast for tile detection

var speed = 150
var jump_force = 200
var crouch_force = 800
var gravity = 400

var slowed : bool = false

@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	
	velocity.x = speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	collision_shape_2d.shape.radius = 10
	if Input.is_action_pressed("crouch"):
		velocity.y = velocity.y + crouch_force * delta
		collision_shape_2d.shape.height = 15
	else:
		collision_shape_2d.shape.height = 30
	
	move_and_slide()
