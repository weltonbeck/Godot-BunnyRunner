extends Node2D

func _ready():
	pass

func _on_Head_body_entered(body):
	body.jump(800, false)
	$Body.collision_mask = 0
	$AudioHurt.play()
	$AnimationSmoke.play("destroy")
	yield($AnimationSmoke,"animation_finished")
	queue_free()

func _on_Body_body_entered(body):
	body.killed()
