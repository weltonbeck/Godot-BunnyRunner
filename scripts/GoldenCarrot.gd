extends Node2D

signal finished

func _ready():
	pass

func play():
	$AnimationPlayer.play("fadein")
	yield($AnimationPlayer,"animation_finished")
	emit_signal("finished")
