extends Node2D

func _ready():
	var tween = get_node("Tween")
	var waves = get_node("background/waves")
	waves.volume_db = -80
	tween.interpolate_property(get_node("Tween/ColorRect"), "color", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(waves, "volume_db", -80, 0, 2, Tween.TRANS_LINEAR)
	tween.start()
	waves.play()

func _on_Tween_tween_all_completed():
	get_node("boombox").doneSeeking()
