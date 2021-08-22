extends AnimatedSprite

# Music Sequencing
# TODO: maybe it should stop at 9 and play a "click" sound
# TODO: for skipping tracks, the sound of a cassette tape fast forwarding would be cool

var currentTrack = 1
var currentTime
var node
var numTracks = 9
var isPlaying = true

func _ready():
	updateNode()

func updateNode():
	node = get_node("tracks/0" + String(currentTrack))

func seek(dir):
	# NOTE: AudioStreamPlayer.finished is emitted when you .stop() it
	pauseTrack()
	
	currentTrack = currentTrack + dir
	if currentTrack < 1:
		currentTrack = 1
	if currentTrack > numTracks:
		currentTrack = numTracks
	updateNode()
	
	playTrack(0)

func nextTrack():
	print("next ", currentTrack)
	if node.is_playing():
		seek(1)
	
func pauseTrack():
	currentTime = node.get_playback_position()
	node.set_stream_paused(true)
	
func playTrack(time):
	node.set_stream_paused(false)
	node.play(time)
	
func togglePlaying():
	print("toggle")
	if node.get_stream_paused():
		playTrack(currentTime)
	else:
		pauseTrack()

func previousTrack():
	print("previous ", currentTrack)
	seek(-1)
	
