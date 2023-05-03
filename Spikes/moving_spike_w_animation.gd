extends Path2D

@onready var sprite = $MovingSpikeFollow/SpikeArea/Sprite2D
@onready var moving_spike_follow = $MovingSpikeFollow
var duration : float = 2

@export var speed : float = 200

var final : int = 1

func _ready():
	moving_spike_follow.progress_ratio = 1
	
	var distance = moving_spike_follow.progress
	duration = distance/speed
	handle_tweening()


func _process(_delta):
	if moving_spike_follow.progress_ratio == 1:
		final = 0
		sprite.flip_h = false
		handle_tweening()
	elif moving_spike_follow.progress_ratio == 0:
		final = 1
		sprite.flip_h = true
		handle_tweening()


func _on_spike_area_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()


func handle_tweening():
	var tween = get_tree().create_tween()
	tween.tween_property(moving_spike_follow, "progress_ratio", final, duration).set_trans(Tween.TRANS_CUBIC)

