extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var length
var fadeTimePct = .2
var fadeTime
var initialVolume
var silentVolume = -80

func scale(val, min0, max0, min1, max1):
	return min1 + (val - min0) * (max1-min1) / (max0 - min0)

# Called when the node enters the scene tree for the first time.
func _ready():
	length = stream.get_length()
	fadeTime = fadeTimePct * length
	initialVolume = get_volume_db()
	set_volume_db(silentVolume)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var currentTime = get_playback_position()
	if currentTime <= fadeTime:
		set_volume_db(scale(currentTime / fadeTime, 0, 1, silentVolume, initialVolume))
	if currentTime > length - fadeTime:
		set_volume_db(scale((length - currentTime) / fadeTime, 0, 1, silentVolume, initialVolume))
