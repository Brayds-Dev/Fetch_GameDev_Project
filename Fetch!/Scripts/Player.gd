extends KinematicBody2D

# References for the animation nodes
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var fountain = get_node("/root/World/Fountain") # Reference to the water fountain

onready var stamina = get_node("/root/World/CanvasLayer/StamBorder/Stamina")  # Reference to the stamina bar

# Set initial varibales
const ACCELERATION = 600
var MAX_SPEED = 300
const FRICTION = 1000

var caught = false

var velocity = Vector2.ZERO

func _physics_process(delta):
	# Code to produce player movement by obtaining input vector
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	# Assign input vector to player movement by speed and acceleration
	# Set the animation state by the input vector
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else: 
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

# On frisbee pick up add score and reduce speed of player
func _on_Area2D_area_entered(area):
	#var frisbee = get_node("/root/World/Human/Frisbee")
	print("caught")
	if MAX_SPEED > 50:
		MAX_SPEED = MAX_SPEED - 50
		stamina.rect_size.x -= 16
	Global.score += 1

# Set speed of player back to original after drinking from fountain
func _on_Area2D_body_entered(body):
	if body == fountain:
		print("Collided")
		MAX_SPEED = 300
		stamina.rect_size.x = 100
