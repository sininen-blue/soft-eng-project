extends Area2D

const slow_factor = 0.5
const slow_time = 1

var is_slowed = false
var slow_timer = null


var player

func ready():
	pass




func _on_body_entered(body) -> void:
	if body.name == "Player":
		
		player = body
		slow_down(body)
		
func slow_down(body) -> void:
	if !is_slowed:
		is_slowed = true
		body.speed *= slow_factor
		slow_timer = $Timer
		slow_timer.start(slow_time)



func _on_timer_timeout() -> void:
	is_slowed = false
	player.speed /= slow_factor
