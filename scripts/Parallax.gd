tool
extends ParallaxBackground

export(Color) var modulate_layer_1 = Color(1,1,1,1) setget set_modulate_layer_1
export(Color) var modulate_layer_2 = Color(1,1,1,1)setget set_modulate_layer_2
export(Color) var modulate_layer_3 = Color(1,1,1,1)setget set_modulate_layer_3
export(Color) var modulate_layer_4 = Color(1,1,1,1)setget set_modulate_layer_4

func _ready():
	set_colors()
	pass

func set_modulate_layer_1(value):
	modulate_layer_1 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
	
func set_modulate_layer_2(value):
	modulate_layer_2 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
	
func set_modulate_layer_3(value):
	modulate_layer_3 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
	
func set_modulate_layer_4(value):
	modulate_layer_4 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
	
func set_colors():
	$Layer1/sprite.modulate = modulate_layer_1
	$Layer2/sprite.modulate = modulate_layer_2
	$Layer3/sprite.modulate = modulate_layer_3
	$Layer4/sprite.modulate = modulate_layer_4
