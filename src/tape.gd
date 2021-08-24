extends AnimatedSprite


# Called when the cur() enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setProgress(pct):
	set_frame(round(pct * 3)) # TODO: this should be based on the number of frames in "tape"
