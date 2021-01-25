extends Node

var prize_file = "user://prize"
var prizes = {}

func save_prize(stage, prize):
	prizes[stage] = prize
	var file = File.new()
	var error = file.open(prize_file, File.WRITE)
	if error == OK:
		file.store_string(to_json(prizes))
		file.close()
		print("file saved")
