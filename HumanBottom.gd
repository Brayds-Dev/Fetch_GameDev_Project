extends KinematicBody2D

onready var player = $"../Player"

onready var animationPlayer = $AnimationPlayer # Reference to the humnans animation player

var projectile = preload ("res://Scenes/FrisbeeBottom.tscn") # Preload frisbee scene to be instantiated

# Set initial variables
var move_speed = 20
var velocity = Vector2.ZERO
var point = Vector2(0,-100)
var stop = 500.0
var moving = true

# Call creation of frisbee as human enters the scene
func _ready():
	throw_frisbee()
	
func _physics_process(delta):
	check_position()
	# Move human to the desired point and set the animation
	if moving:
		animationPlayer.play("RunUp")
		velocity = velocity.move_toward(point, move_speed)
		velocity = move_and_slide(velocity)
	else:
		animationPlayer.play("IdleUp")
		velocity = Vector2.ZERO


func check_position(): # Stop the human from walking once desired position has been reached
	if global_position.y < stop:
		moving = false

func throw_frisbee(): # Instantiate frisbee and set its position
	var p = projectile.instance()
	p.position = Vector2(0, -13)
	add_child(p)

# Timer to remove human and reduce score if frisbee has not been picked up
func _on_Timer_timeout():
	var f = get_node("FrisbeeBottom")
	if f.visible == true and Global.score > 0:
		Global.score -= 1
	queue_free()
