extends Area2D


func _ready():
	get_tree().call_group("game", "add_stage_coins")
	

func _on_Coin_body_entered(_body):
	$AudioCoin.play()
	$AnimatedSprite.visible = false
	collision_mask = 0
	$Particles2D.emitting = true
	$DestroyTimer.start()
	get_tree().call_group("coin_counter", "pick_coin")


func _on_DestroyTimer_timeout():
	queue_free()
