extends Timer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# if a node that is already playing is chosen, it restarts
func doTheWave():
	get_node("0" + String(rng.randi_range(1, 4))).play(0)
