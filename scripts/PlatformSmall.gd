tool
extends StaticBody2D

var textures = [
	"res://sprites/Environment/ground_grass_small.png",
	"res://sprites/Environment/ground_cake_small.png",
	"res://sprites/Environment/ground_sand_small.png",
	"res://sprites/Environment/ground_snow_small.png",
	"res://sprites/Environment/ground_stone_small.png",
	"res://sprites/Environment/ground_wood_small.png"
]

export(int, 'grass', 'cake', 'sand', 'snow', 'stone', 'wood') var texture = 0 setget set_texture

func _ready():
	pass
	
func _draw():
	$Sprite.texture = load(textures[texture])

func set_texture(value):
	texture = value
	if is_inside_tree() && Engine.editor_hint:
		update()
