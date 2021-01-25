extends Node2D

onready var size = $Bar.rect_size

func _ready():
	add_to_group("power_up_bar")
	visible = false
	pass

func start(time):
	visible = true
	$Tween.interpolate_method(self, "count", 1, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	$Tween.start()

func stop():
	$Tween.stop_all()
	visible = false

func count(value):
	$Bar.rect_size = Vector2(size.x * value, size.y)

func _on_Tween_tween_completed(_object, _key):
	stop()
	get_tree().call_group("player", 'power_up_finished')
	
