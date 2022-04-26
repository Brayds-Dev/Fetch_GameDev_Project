extends KinematicBody2D

var projectile = preload ("res://Scenes/Frisbee.tscn")  # ready the frisbee scene for instantiation

onready var animationPlayer = $AnimationPlayer  # Reference to the humnans animation player

# Initial variables for the human
var move_speed = 20
var velocity = Vector2.ZERO
var point = Vector2(0,41)
var stop = 41.0
var moving = true

# Called when the node enters the scene tree for the first time.
func _ready():
	throw_frisbee()


func _process(delta):
	check_position()
	# Move human to the desired point and set the animation
	if moving:
		animationPlayer.play("RunDown")
		velocity = velocity.move_toward(point, move_speed)
		velocity = move_and_slide(velocity)
	else:
		animationPlayer.play("IdleDown")
		velocity = Vector2.ZERO
		
func check_position():  # Stop the human from walking once desired position has been reached
	if global_position.y > stop:
		moving = false
		
func throw_frisbee():  # Instantiate frisbee and set its position
	var p = projectile.instance()
	p.position = Vector2(0, 11)
	add_child(p)

# Timer to remove human and reduce score if frisbee has not been picked up
func _on_Timer_timeout():
	var f = get_node("Frisbee")
	if f.visible == true and Global.score > 0:
		Global.score -= 1
	queue_free()

