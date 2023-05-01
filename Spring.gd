extends Area2D

var spring = -200

@onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	if body.name == "Player":
		body.velocity.y = spring
		animation_player.play("activate")
