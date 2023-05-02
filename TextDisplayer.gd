extends RichTextLabel

var ms = 0
var s = 0
var m = 0
var h = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ms > 9:
		s += 1
		ms = 0
		
	if s > 59:
		m += 1
		s = 0
	
	if m > 59:
		h += 1
		m = 0
		
	set_text(str(h)+":"+str(m)+":"+str(s)+":"+str(ms))


func _on_ms_timeout():
	ms += 1
	pass # Replace with function body.
