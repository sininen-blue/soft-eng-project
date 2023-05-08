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
var pressing_jump : bool = true


@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player = $AnimationPlayer

@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer



func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _physics_process(delta):
	handle_animations()
	
	velocity.y += gravity * delta
	
	velocity.x = speed
	
	
	# jump
	if is_on_floor():
		coyote_timer.start()
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
	pressing_jump = Input.is_action_pressed("jump")
	
	
	if !coyote_timer.is_stopped() and !jump_buffer_timer.is_stopped() and pressing_jump:
		coyote_timer.stop()
		jump_buffer_timer.stop()
		velocity.y = -jump_force
		# this makes sure you can't full jump if you tap space fast enough
	elif !coyote_timer.is_stopped() and !jump_buffer_timer.is_stopped() and !pressing_jump:
		coyote_timer.stop()
		jump_buffer_timer.stop()
		velocity.y = -jump_force/3
	
	
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



