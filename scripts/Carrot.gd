extends Area2D


func _ready():
	pass


func _on_Carrot_body_entered(body):
	body.victory()


func _on_DeadZone_body_entered(body):
	body.killed()
