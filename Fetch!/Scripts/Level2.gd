extends Node2D


var human = preload ("res://Scenes/Human.tscn")  # Load human scene for instantiation
var human_bottom = preload ("res://Scenes/HumanBottom.tscn") # Load human bottom scene for instantiation

# Load new scene depending on game state
func _process(delta):
	if Global.time == 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	elif Global.score == 10:
		get_tree().change_scene("res://Scenes/Level2Complete.tscn")

# code to spawn humans at random
func _on_Timer_timeout():
	var h = human.instance()
	h.position = Vector2(randi()%1001, 1)
	add_child(h)
	var hb = human_bottom.instance()
	hb.position = Vector2(randi()%1001, 590)
	add_child(hb)
