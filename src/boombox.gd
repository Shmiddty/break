extends AnimatedSprite

# Music Sequencing
var seekDir = 0
var currentTrack = 0
var currentTime = 0
var numTracks = 9
var playTime = 0

var nodes = []
var times = []
var runningTime = []

func initNodes():
	var prevTime = 0
	for n in numTracks:
		nodes.append(get_node("tracks/0" + String(n + 1)))
		times.append(nodes[n].stream.get_length())
		if n > 0:
			prevTime = runningTime[n - 1]
			
		runningTime.append(prevTime + times[n])
	pass

func cur():
	return nodes[currentTrack]

func _ready(): 
	initNodes()
	pass
	
func _process(delta):
	var prev = 0
	if currentTrack > 0:
		prev = runningTime[currentTrack - 1]
	playTime = prev + cur().get_playback_position()
	get_node("tape").setProgress(playTime/runningTime[numTracks-1])
	# this works but isn't quite right.
	# TODO: this does't currently account for tape position based on seeking.
	pass

func seek(dir):
	currentTrack = currentTrack + dir
	if currentTrack < 0:
		currentTrack = 0
	elif currentTrack >= numTracks:
		currentTrack = numTracks - 1
	else:
		currentTime = 0
	pass

func playClick():
	get_node("click").play(0)
	pass

func getSeekTime(dir):
	var pos = cur().get_playback_position()
	if dir > 0 && currentTrack < numTracks - 1:
		return times[currentTrack] - pos
	elif dir < 0 && currentTrack > 0:
		return pos + times[currentTrack - 1]
	elif dir < 0 && currentTrack == 0:
		return pos
	else:
		return 0
	pass

func startSeeking(dir):
	if dir == 1 && currentTrack == numTracks - 1:
		return
		
	# TODO: handle interrupted seeks correctly. 
	seekDir = dir
	var time = getSeekTime(dir) / 32
	get_node("seeking").play(rand_range(0, 5))
	get_node("Timer").set_wait_time(time)
	get_node("Timer").start()
	pass
	
func doneSeeking():
	get_node("seeking").stop()
	pass

func _actually_play():
	seek(seekDir)
	cur().set_stream_paused(false)
	cur().play(currentTime)
	pass

func boom_play():
	play("play")
	get_node("postSeekClick").play(0)
	pass
	
func boom_pause():
	playClick()
	play("pause")
	currentTime = cur().get_playback_position()
	cur().set_stream_paused(true)
	pass
	
func boom_toggle():
	if cur().get_stream_paused():
		boom_play()
	else:
		boom_pause()

func boom_fforward():
	playClick()
	play("fast_forward")
	cur().set_stream_paused(true)
	startSeeking(1)
	pass
	
func boom_rewind():
	playClick()
	play("rewind")
	cur().set_stream_paused(true)
	startSeeking(-1)
	pass

func nextTrack():
	seekDir = 1
	_actually_play()
