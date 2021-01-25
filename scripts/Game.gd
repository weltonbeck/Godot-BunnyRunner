extends Node

var pre_golden_carrots = load("res://scennes/GoldenCarrots.tscn")
var golden_carrots

enum {
	MENU, LOADING, LOADED
}

var prize_carrots = [
	{
		average = 0.3,
		prize = 1
	},
	{
		average = 0.7,
		prize = 2
	},
	{
		average = 0.9,
		prize = 3
	}
]

var status = MENU

var current_music
var current_stage
var current_stage_name
var loaded_stage
var ref_stage
var stage_coins

func _ready():
	add_to_group("game")
	$HUD/BtnStageExit.visible = false

func stage_selected(button):
	if status == MENU:
		status = LOADING
		current_stage = button.stage
		current_stage_name = button.stage_name
		current_music = button.music
		$SelectStageInterface/Bunny/AnimationPlayer.stop()
		$SelectStageInterface.visible = false
		$HUD/Controls.visible = true
		$HUD/BtnStageExit.visible = true
		load_stage()
		status = LOADED
		
func load_stage():
	stage_coins = 0
	$HUD/Controls/CoinCounter.coins = 0
	if loaded_stage != null && ref_stage.get_ref() != null:
		loaded_stage.queue_free()
		
	loaded_stage = load(current_stage).instance()
	ref_stage = weakref(loaded_stage)
	if current_music:
		$AudioMusic.stream = load(current_music)
	add_child(loaded_stage)
	$HUD/Countdown/AnimationPlayer.play("count")
	yield($HUD/Countdown/AnimationPlayer,"animation_finished")
	get_tree().call_group("player", "start")
	play_music()

func player_died():
	stop_music() 
	load_stage()

func exit_stage():
	stop_music() 
	if loaded_stage != null:
		loaded_stage.queue_free()
	$SelectStageInterface/Bunny/AnimationPlayer.play("happy")
	$SelectStageInterface.visible = true
	$HUD/Controls.visible = false
	$HUD/BtnStageExit.visible = false
	$HUD/Countdown.visible = false
	status = MENU
	
	if golden_carrots != null && weakref(golden_carrots):
		golden_carrots.queue_free()

func player_victory():
	stop_music()
	$AudioVictory.play()
	var average = float($HUD/Controls/CoinCounter.coins) / float(stage_coins)
	var prize = 0
	for pc in prize_carrots:
		if average >= pc.average:
			prize = pc.prize
	golden_carrots = pre_golden_carrots.instance()
	$HUD.add_child(golden_carrots)
	golden_carrots.play(prize)
	GAME_DATA.save_prize(current_stage_name, prize)
	yield(golden_carrots, "carrots_finished")
	var t = get_tree().create_timer(2)
	yield(t,"timeout")
	exit_stage()
	
func player_dying():
	stop_music()

func _on_BtnStageExit_pressed():
	exit_stage()

func play_music():
	if current_music:
		$AudioMusic.play()

func stop_music():
	if current_music:
		$AudioMusic.stop()

func add_stage_coins():
	stage_coins += 1
