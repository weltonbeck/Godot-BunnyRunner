extends Node2D

var coins = 0 setget set_coins

func _ready():
	add_to_group("coin_counter")
	
func set_coins(value):
	coins = value
	update_label()

func pick_coin():
	self.coins += 1

func update_label():
	$LabelCoins.text = str(coins).pad_zeros(5)
