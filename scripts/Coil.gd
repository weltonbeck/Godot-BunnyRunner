extends Area2D


func _ready():
	pass


func _on_Coil_body_entered(body):
	$Sprite.play("action")
	$AudioAction.play()
	body.jump(1500, false)
