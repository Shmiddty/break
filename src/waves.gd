extends Timer

var rng = RandomNumberGenerator.new()

# Called when the cur() enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# if a cur() that is already playing is chosen, it restarts
func doTheWave():
	get_cur()("0" + String(rng.randi_range(1, 4))).play(0)
