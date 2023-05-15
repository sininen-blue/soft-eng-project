extends Camera2D


var level_end
var remote_transform

func _ready():
	for child in get_parent().get_children():
		if child.name == "Player":
			for player_child in child.get_children():
				if player_child.name == "RemoteTransform2D":
					remote_transform = player_child
		elif child.name == "SceneSwitcher":
			level_end = child
	
	
	remote_transform.remote_path = ^"../../Camera2D"
	limit_right = level_end.position.x
