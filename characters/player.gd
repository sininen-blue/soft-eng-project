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

var is_rolling : bool = true

@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player = $AnimationPlayer


func _ready():
	Engine.time_scale = 1
	
	$RemoteTransform2D.position = Vector2(130, -30)
	
	$DeathMenu.visible = false


func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _physics_process(delta):
	handle_animations()
	
	velocity.y += gravity * delta
	
	velocity.x = speed
	
	
	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	var going_up = velocity.y < 0
	var early_jump = velocity.y < jump_force/2
	if Input.is_action_just_released("jump") and going_up and early_jump:
		velocity.y = -jump_force/3
	
	# roll
	collision_shape_2d.shape.radius = 7
	is_rolling = Input.is_action_pressed("crouch")
	if Input.is_action_pressed("crouch"):
		velocity.y = velocity.y + crouch_force * delta
		collision_shape_2d.shape.height = 15
	else:
		collision_shape_2d.shape.height = 18
	
	move_and_slide()


func handle_animations():
	if is_rolling:
		animation_player.play("roll")
	else:
		if !is_on_floor():
			animation_player.play("jump")
		else:
			animation_player.play("run")


func kill():
	$DeathMenu.visible = true
	Engine.time_scale = 0
