extends AnimatedSprite

# Music Sequencing
# TODO: maybe it should stop at 9 and play a "click" sound
# TODO: for skipping tracks, the sound of a cassette tape fast forwarding would be cool

var rng = RandomNumberGenerator.new()
var click
var seeking
var seekTimer
var seekDir = 1
var currentTrack = 1
var currentTime
var node
var numTracks = 9
var isPlaying = true

func _ready():
	updateNode()

func updateNode():
	node = get_node("tracks/0" + String(currentTrack))
	click = get_node("click")
	seeking = get_node("seeking")
	seekTimer = get_node("Timer")

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
	#if node.is_playing():
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

func playClick():
	click.play(0)

func getSeekTime(dir):
	var pos = node.get_playback_position()
	if dir > 0 && currentTrack < numTracks:
		return node.stream.get_length() - pos
	elif dir < 0 && currentTrack > 1:
		return pos + get_node("tracks/0" + String(currentTrack - 1)).stream.get_length()
	elif dir < 0 && currentTrack == 1:
		return pos
	else:
		return 0

func startSeeking(dir):
	if dir == 1 && currentTrack == numTracks:
		return
		
	seekDir = dir
	var time = getSeekTime(dir) / 32
	
	print("seek ", time)
	if time > 1:
		pauseTrack()
		seeking.play(rand_range(0, 5))
		seekTimer.set_wait_time(time)
		seekTimer.start()
	else:
		seek(dir) 
	
func doneSeeking():
	seeking.stop()
	click.play(0)
	if seekDir > 0:
		nextTrack()
	else:
		previousTrack()
