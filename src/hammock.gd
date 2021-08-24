extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hammockCount = 0
var hammockMax = 2

# Called when the cur() enters the scene tree for the first time.
#func _ready():

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Hammock Interaction
# TODO: I want this to cause the hammock to swing a few times and then settle back to a stop
# it would be nice if the hammock started moving quickly and then slowed down to a stop
func sway():
	play()

func _on_hammock_animation_finished():
	hammockCount = hammockCount + 1
	if hammockCount == hammockMax:
		stop()
		hammockCount = 0
