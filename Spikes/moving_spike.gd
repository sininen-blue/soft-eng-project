extends Path2D

@onready var moving_spike_follow = $MovingSpikeFollow
@export var duration : float = 2

var speed : float = 200
var final : int = 1

func _ready():
	moving_spike_follow.progress_ratio = 1
	var distance = moving_spike_follow.progress
	duration = distance/speed
	handle_tweening()


func _process(_delta):
	if moving_spike_follow.progress_ratio == 1:
		final = 0
		handle_tweening()
	elif moving_spike_follow.progress_ratio == 0:
		final = 1
		handle_tweening()


func _on_spike_area_body_entered(body):
	if body.name == "Player":
		pass # should have body.kill here


func handle_tweening():
	var tween = get_tree().create_tween()
	tween.tween_property(moving_spike_follow, "progress_ratio", final, duration).set_trans(Tween.TRANS_CUBIC)
