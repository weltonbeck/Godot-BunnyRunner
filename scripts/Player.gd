extends KinematicBody2D

const SPEED = 300
const GRAVITY = 1500
var velociy = Vector2(0, 0)
var is_jump = false
var jump_release = false
var was_on_floor = false
var controled_jump = false

enum {
	IDLE, RUNNING, FLYING, DEAD, VICTORY
}

var status = IDLE
onready var mask = collision_mask
onready var layer = collision_layer

func _ready():
	add_to_group("player")
	$AnimatedSprite.play("idle")
	pass
	
func _input(event):
	if event is InputEventScreenTouch || event.is_action("ui_jump"):
		if event.pressed:
			is_jump = true
		else :
			jump_release = true

func _physics_process(delta):
	if status == RUNNING:
		running(delta)
	elif status == FLYING:
		flying(delta)
	elif status == DEAD:
		dead(delta)
		
	if status != DEAD && position.y > ProjectSettings.get_setting("display/window/size/height"):
		killed()
		
	is_jump = false
	jump_release = false
	
func running(delta):
	velociy.y += GRAVITY * delta
	velociy.x = SPEED
	velociy = move_and_slide(velociy, Vector2(0, -1))
	
	if is_on_floor() :
		$AnimatedSprite.play("walk")
		if ! was_on_floor:
			$AnimationLanded.play("boing")
			$Dust/AnimationDust.play("dust")
		if is_jump:
			$AudioJump.play()
			jump(1000, true)
	else:
		$AnimatedSprite.play("jump")
		if jump_release && velociy.y < 0 && controled_jump:
			velociy.y *= .3
	
	was_on_floor = is_on_floor()

func jump(force, controled):
	velociy.y = -force
	controled_jump = controled
	
func flying(delta):
	velociy.y += GRAVITY * delta
	velociy.x = SPEED
	velociy = move_and_slide(velociy, Vector2(0, -1))
	if is_jump:
		$Wings/AnimationPlayer.play("flap")
		$Wings/AudioFlap.play()
		jump(500, false)
		
	if is_on_floor():
		power_up_finished()
		get_tree().call_group("power_up_bar", 'stop')
	
func dead(delta):
	$AnimatedSprite.play("hurt")
	translate(velociy * delta)
	velociy.y += GRAVITY * delta
	
	if position.y > ProjectSettings.get_setting("display/window/size/height"):
		get_tree().call_group("game", "player_died")
		
func killed():
	if status != DEAD:
		status = DEAD
		collision_mask = 0
		collision_layer = 0
		velociy = Vector2(0, -1000)
		$AudioDead.play()
		get_tree().call_group("power_up_bar", 'stop')
		get_tree().call_group("game", 'player_dying')
		
func fly():
	$AnimatedSprite.play("jump")
	jump(500, false)
	$Wings.visible = true
	status = FLYING

func victory():
	$AnimatedSprite.play("victory")
	status = VICTORY
	get_tree().call_group("game", "player_victory")

func power_up_finished():
	if status != DEAD && status != VICTORY:
		status = RUNNING
		$Wings.visible = false
		
func start():
	status = RUNNING
